## store repo directory because this script changes dir a few times
CURDIR=$PWD

## create folder architecture
mkdir ~/downloads
mkdir ~/downloads/deb-packages
mkdir ~/devtools
mkdir ~/projects
mkdir ~/scripts
mkdir ~/scripts/asm
mkdir ~/scripts/cpp
mkdir ~/scripts/dart
mkdir ~/scripts/php
mkdir ~/scripts/python
mkdir ~/scripts/js
mkdir ~/.ssh
mkdir ~/.bash-extensions

## install basic things that are needed
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install wget curl man-db iputils-ping htop nasm unzip

## install php7.2
sudo apt-get -y install apt-transport-https lsb-release ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

sudo apt-get update
sudo apt-get -y install php7.2

sudo apt-get -y install php7.2-cli php7.2-common php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-xml php7.2-zip

## install composer globally
EXPECTED_SIGNATURE="$(wget -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
	>&2 echo 'ERROR: Invalid Composer installer signature'
	rm composer-setup.php
	exit 1
fi
php composer-setup.php
php -r "unlink('composer-setup.php');"


sudo mv composer.phar /usr/local/bin/composer

## install python
sudo apt-get -y install python3 python3-pip

## install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install nodejs -y

## install dart
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt-get update
sudo apt-get -y install dart

## install dotnet core
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget -q https://packages.microsoft.com/config/debian/9/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

sudo apt-get update
sudo apt-get install dotnet-sdk-3.0

## install sublime text and merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text sublime-merge

## install visual studio code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get -y install code

## install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## install gimp
sudo apt-get -y install gimp

## install okular
sudo apt-get -y install okular

## install thunderbird
sudo apt-get -y install thunderbird

## install flutter globally
cd ~/devtools
wget https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_v0.8.2-beta.tar.xz -O flutter.tar.xz
tar xf flutter.tar.xz
rm flutter.tar.xz
yes | flutter doctor --android-licenses
# flutter is moved to path in .bash-exports
# install lib32stdc++6 dependency
sudo apt-get -y install "lib32stdc++6"
# install adb, needed for android development
sudo apt-get -y install adb

## create custom aliases and functions files
cd $CURDIR
source create-bashfiles.sh
cd $CURDIR && cd ..
source create-profiles.sh
source npm-installs.sh
source pip-installs.sh
source composer-installs.sh
cd $CURDIR

