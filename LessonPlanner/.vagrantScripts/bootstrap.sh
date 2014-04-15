#!/usr/bin/env bash
sudo apt-get update;
sudo apt-get install -y python-software-properties rubygems vim;
sudo add-apt-repository ppa:chris-lea/node.js;
sudo apt-get update;
sudo apt-get install -y nodejs;
cd /vagrant/ 
npm install;
sudo npm install -g yo;
sudo npm install -g generator-angular;
sudo gem install compass;
echo "cd /vagrant/;" | sudo tee -a /home/vagrant/.bashrc;
echo "grunt serve;" | sudo tee -a /home/vagrant/.bashrc;