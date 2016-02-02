#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install vlc
sudo apt-get install python-pip
sudo apt-get install g++
sudo apt-get install nodejs
sudo apt-get install npm
sudo apt-get install git
sudo apt-get install erlang
sudo apt-get install gdebi
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
sudo apt-get install curl
curl -sSf https://static.rust-lang.org/rustup.sh | sh

sudo apt-get install texlive-base texlive-bibtex-extra 
sudo apt-get install texlive-fonts-recommended
sudo apt-get install texlive-fonts-extra
sudo apt-get install texlive-latex-base
sudo apt-get install texlive-latex-extra
sudo apt-get install texlive-latex-recommended
sudo apt-get install texlive-science

sudo ln -s /usr/bin/nodejs /usr/bin/node

#Mongo DB

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org
