#!/bin/bash

apt-add-repository ppa:brightbox/ruby-ng
apt update
apt install ruby2.5
gem install bundler
bundle update
bundle install