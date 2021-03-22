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
		# Loop through all invalidations
		while IFS= read -r invalidationid
		do
			echo "Waiting for invalidation $invalidationid to complete..."
			# Poll every 20 seconds (built into AWS command), Wait until invalidation has completed
			# See https://docs.aws.amazon.com/cli/latest/reference/cloudfront/wait/invalidation-completed.html for more info
			aws cloudfront wait invalidation-completed --distribution-id "$CLOUDFRONT_DIST_ID" --id "$invalidationid"
			HorizontalRule
			echo "Invalidation $invalidationid completed"
		done <<< "$invalidations"
		# All invalidations completed, exit script
		scriptExit
	fi
}

# Make sure jq exists on the system
checkCommand "jq"
# Grab all invalidations
listInvalidations
# Make sure invalidations are completed
checkInvalidationstatus
