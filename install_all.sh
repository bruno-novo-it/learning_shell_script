echo -e "\nInstalling all the things!!\n"

echo -e "\nAdding Google Chrome Key and Repository\n"

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo add-apt-repository ppa:openjdk-r/ppa -y #Add Java JDK Repository

sudo add-apt-repository ppa:linrunner/tlp -y # Add TLP(PowerSave) repository

sudo apt-get update -y

sudo apt-get install -y curl google-chrome-stable git htop node-gyp vim zsh fonts-powerline bash-completion python-pip preload ansible \
awscli apt-transport-https virtualbox make automake build-essential zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev tlp tlp-rdw indicator-cpufreq autoconf libtool libusb-dev libpcsclite-dev \
p7zip git libreadline5 libreadline-dev libusb-0.1-4 libqt4-dev perl pkg-config libncurses5-dev \
gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib libnss3-tools libdbus-1-dev openjdk-8-jdk gdebi \
equivs lsb npm zram-config preload unity-tweak-tool compizconfig-settings-manager cmake libboost-all-dev -y

sudo apt-get update -y

sudo apt autoremove -y

# Change TLP ON AC TO PERFORMANCE FOR BETTER OPTMIZATION
sudo sed -i s'/#CPU_SCALING_GOVERNOR_ON_AC=powersave/CPU_SCALING_GOVERNOR_ON_AC=performance/g' /etc/tlp.conf

sudo tlp start

echo "Installing JDownloader..."

wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
chmod +x JD2SilentSetup*.sh
./JD2SilentSetup*.sh
rm -rf JD2SilentSetup*.sh

# Install Mongo on Ubuntu
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
sudo bash -c 'echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'
sudo apt update
sudo apt install mongodb-org

echo "Installing Pyenv"

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc # ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc # ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc # ~/.bashrc
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc # ~/.bashrc
source ~/.zshrc # ~/.bashrc
pyenv install 3.6.5
pyenv shell 3.6.5
pyenv virtualenv 3.6.5 python-$USER
pyenv activate python-$USER

echo "Installing AWS-cli and Boto3 and py-test"

sudo pip install awscli --force-reinstall --upgrade

#VERIFY THE LATEST VERSION IN --> https://kubernetes.io/docs/imported/release/notes/
echo "Installing Latest Kubectl version..."

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl

#VERIFY THE LATEST VERSION IN --> https://github.com/kubernetes/minikube/releases
#echo "Installing Minikube..."

#curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

echo "Installing Kops"

curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

chmod a+x kops-linux-amd64

sudo mv kops-linux-amd64 /usr/local/bin/kops

echo "Installing Docker CE"

sudo curl -sSL https://get.docker.com/ | sh

sudo groupadd docker

sudo gpasswd -a $USER docker

sudo usermod -aG docker $USER

newgrp docker

echo "Installing Docker-compose"

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && curl -L https://raw.githubusercontent.com/docker/compose/1.21.2/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

sudo apt-get update && apt-get upgrade

echo "Installing nvm..."

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

echo "Installing Visual Studio Code..."

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code

echo 'fs.inotify.max_user_watches=524288' | sudo tee /etc/sysctl.conf

sudo sysctl -p

echo -e "\nInstalling Warsaw..."

wget http://security.ubuntu.com/ubuntu/pool/main/p/pygpgme/python-gpgme_0.3-1.2build2_amd64.deb

sudo gdebi python-gpgme*.deb

echo -e "\nInstalling Spotify..."

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install -y spotify-client

# Install TeamViewer
echo -e "\nInstalling TeamViewer"

sudo apt install -y gdebi-core

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb

sudo gdebi -y teamviewer_amd64.deb

rm -rf teamviewer_amd64

## Install Powerline fonts for ZSH
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

echo -e "\nInstalling ZSH"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "\nInstalling zsh Completion"

git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

mkdir -p ~/.zsh/completion
