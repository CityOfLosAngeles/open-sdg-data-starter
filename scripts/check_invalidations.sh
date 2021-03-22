#!/usr/bin/env bash

# Modified from https://github.com/swoodford/aws/blob/master/cloudfront-invalidation-status.sh

# This script monitors CloudFront distributions for cache invalidation status and alerts when it has completed
# Requires the AWS CLI and jq

# Functions

# Check Command Exists
function checkCommand {
	type -P $1 &>/dev/null || fail "Unable to find $1, please install it and run this script again."
}

# Completed Script
function scriptExit(){
	HorizontalRule
	echo "Exiting Script"
	HorizontalRule
	echo
	exit 0
}

# Script Failed
function fail(){
	echo "Failure: $*"
	exit 1
}

# Horizontal Rule, print divider line
function HorizontalRule(){
	echo "============================================================"
}

# List Cloudfront Invalidations
function listInvalidations(){
	HorizontalRule
	echo "Checking for Invalidations In Progress..."

	# jq used to parse aws json output
	invalidations=$(aws cloudfront list-invalidations --distribution-id $CLOUDFRONT_DIST_ID | jq '.InvalidationList | .Items | .[] | select(.Status != "Completed") | .Id' | cut -d \" -f2)
	# Check if invalidation exists, if so output status
	if ! [ -z "$invalidations" ]; then
		HorizontalRule
		echo "Invalidation in progress: $invalidations"
		HorizontalRule
	fi
}

# Check the Cloudfront Invalidation Status
function checkInvalidationstatus(){
	# Check if invalidation exists, if not exit script
	if [ -z "$invalidations" ]; then
		echo No CloudFront Invalidations In Progress.
		HorizontalRule
		return 1
	else
		while IFS= read -r invalidationid
		do
			# jq used to parse aws json output
			invalidationStatus=$(aws cloudfront get-invalidation --distribution-id $CLOUDFRONT_DIST_ID --id $invalidationid | jq '.Invalidation | .Status' | cut -d \" -f2)

			# While invalidation in progress, sleep for 10 seconds and check again
			while [ $invalidationStatus = "InProgress" ]; do
				HorizontalRule
				echo "Invalidation ID: $invalidationid" 
				echo "Status: $invalidationStatus"
				echo "Waiting for invalidation to complete..."
				HorizontalRule
				sleep 10
				checkInvalidationstatus
			done

			# If invalidation is completed, exit the script
			if [ $invalidationStatus = "Completed" ]; then
				echo "CloudFront Invalidation $invalidationStatus"
				scriptExit
			fi
		done <<< "$invalidations"
	fi
}

# Make sure jq exists on the system
checkCommand "jq"
# Grab all invalidations
listInvalidations
# Make sure invalidations are completed
checkInvalidationstatus
