#!/bin/bash

# Curl and Git
sudo apt-get install -y \
  git \
  build-essential \
  curl \
  wget

# Setup and Update packages

sudo apt-get update

# Ruby
sudo apt-get install -y libyaml-dev
#sudo apt-get install -y ruby2.2        # Or the version you are using
#sudo update-alternatives --set ruby /usr/bin/ruby2.2

# Fix broken Ubuntu rvm:
sudo apt-get --purge remove -y ruby-rvm
apt-get autoremove
sudo rm -rf /usr/share/ruby-rvm /etc/rvmrc /etc/profile.d/rvm.sh
unset rvm_path

\curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -L https://get.rvm.io |
  bash -s stable --ruby --autolibs=enable --auto-dotfiles
source /usr/local/rvm/scripts/rvm
gem install bundler
rvm pkg install libyaml
rvm reinstall all --force
rvm install 2.0.0-p481
