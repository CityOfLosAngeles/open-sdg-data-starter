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
- Install VS Code and the Dev Containers extension within the Ubuntu WSL2 installation.


You want to install the [Docker Community Edition via the Apt Repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) method on Ubuntu. Then proceed with the post-installation steps for Docker Engine, specifically the section for [Managing Docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/). Please note to copy each
command within the code blocks individually to prevent any issues with installation. You may also need to run `sudo service docker start` before running the `sudo docker run hello-world` command
listed in the documentation.

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




