### Git
sudo apt install Git

### Github Desktop

# https://gist.github.com/berkorbay/6feda478a00b0432d13f1fc0a50467f1
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb
# Uncomment below line if you have not installed gdebi-core before
# sudo apt-get install gdebi-core 
sudo gdebi GitHubDesktop-linux-3.1.1-linux1.deb

### Docker
sudo apt install Docker

### visual studio code 
wget https://az764295.vo.msecnd.net/stable/1ad8d514439d5077d2b0b7ee64d2ce82a9308e5a/code_1.74.1-1671015296_amd64.deb | deb

#python 
sudo apt install python3

# powershell 
# Update the list of packages
sudo apt-get update
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt-get update
# Install PowerShell
sudo apt-get install -y powershell



