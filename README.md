# Open SDG - Data starter ![Build and Deploy Development Data](https://github.com/CityOfLosAngeles/open-sdg-data-starter/workflows/Build%20and%20Deploy%20Development%20Data/badge.svg) ![Build and Deploy Production Data](https://github.com/CityOfLosAngeles/open-sdg-data-starter/workflows/Build%20and%20Deploy%20Production%20Data/badge.svg)



### Getting Started w/ Local Development Environment

#### Environment Details
```
OS: Ubuntu 22.04 LTS x86-64
Text Editor: Visual Studio Code
Docker Engine: ^25.0.3
```
#### VS Code Editor Extensions Installed
```
- Dev Containers
    - ID: ms-vscode-remote.remote-containers
    - Version: ^0.338.1
    - Publisher: Microsoft
    - VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
```

If you are not running Ubuntu natively you will need to configure your host system to run it. If you are running Windows we recommend running [Windows Subsystem for Linux (WSL2)](https://learn.microsoft.com/en-us/windows/wsl/install). Please follow the instructions on the website to install Ubuntu 22.04. There will be several `wsl` commands that will need to be ran.

*Considerations for WSL2 Installation:*
- Admin privileges are required.
- If the Windows Store is deactivated on your PC, for every `wsl` command, run `wsl.exe`.
    - The installation may only require running `wsl.exe --update --web-download` followed by `wsl.exe --install -d Ubuntu-22.04 --web-download`
- Install VS Code and the Dev Containers extension within the Ubuntu WSL2 installation.


We will be using Visual Studio Code's Dev Containers to run commands to verify and build our site for local verification and testing.
Dev Containers require the installation of Docker. You want to install the [Docker Community Edition via the Apt Repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) method on Ubuntu. Then proceed with the post-installation steps for Docker Engine, specifically the section for [Managing Docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/).
Please note to copy each command within the code blocks individually to prevent any issues with installation as copying all lines from the code blocks may improperly run the commands. You may also need to run `sudo service docker start` before running the `sudo docker run hello-world` command listed in the documentation.

For VS Code install it with th method you prefer unless you are using WSL 2. If using WSL 2, run the following commands inside Ubuntu:

```
sudo apt update
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code
echo "alias code='DONT_PROMPT_WSL_INSTALL=1 code'" >> ~/.bashrc
source .bashrc
code --version
```

Moving forward, launch VS Code with `code` or `code .` when wanting to open VS Code with a project folder.

#### Validating & Building Data

##### Building & Starting the Environment

Once confirmed that the Dev Container extension has been installed you should be able to use the keyboard shortcut `Ctrl + Shift + P`
to access the Command Pallette to select and run commands for Dev Container to build, rebuild, and connect to the local development environment.

The command to build / rebuild is `>dev containers: rebuild container`.

The command to connect to the local development environment is `>dev containers: reopen in container` or `>dev containers: open in container`.

The configuration for the environment is in `.devcontainer/.devcontainer.json`. Any time the `.devcontainer/.devcontainer.json` file or `scripts/requirements.txt` has been modified, a rebuild of the environment will need to occur.

##### Validating Data & Building the Date Site

Verify the data by running `python scripts/check_data.py`.

Build the site by running `python scripts/build_data.py`. The `_site` folder should be either created or have it's contents updated.

Review how to manage data with information provided on the Open SDG project's documentation website [here](https://open-sdg.readthedocs.io/en/latest/data-format/).

### GitHub Actions

GitHub Actions is used for building, verifying, and deploying the site contents. The production GitHub Actions workflow file, `BuildNDeployProd.yml` is currently configured to build, verify, and deploy the site to the production environment.
The pdevelopment GitHub Actions workflow file, `BuildNDeployDev.yml` currently is configured to build and verify the site when git pushes are made to any branch but `production` verifying changes within the branch that was pushed. On git pushes to the `development` branch, the workflow will proceed to build, verify, and deploy the site to the development environment.
