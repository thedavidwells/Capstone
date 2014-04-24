#!/usr/bin/env bash
sudo apt-get update;
sudo apt-get install -y python-software-properties rubygems vim curl;
sudo add-apt-repository ppa:chris-lea/node.js;
sudo apt-get update;
sudo apt-get install -y nodejs git;
cd /vagrant/ 
npm install;
sudo npm install -g yo;
sudo npm install -g generator-angular;
sudo gem install compass;
curl -s https://www.parse.com/downloads/cloud_code/installer.sh | sudo /bin/bash
echo "cd /vagrant/;" | sudo tee -a /home/vagrant/.bashrc;
echo "export CI=true" | sudo tee -a /home/vagrant/.bashrc;
echo "bower install;" | sudo tee -a /home/vagrant/.bashrc;
echo "grunt bowerInstall;" | sudo tee -a /home/vagrant/.bashrc;
echo "grunt serve;" | sudo tee -a /home/vagrant/.bashrc;