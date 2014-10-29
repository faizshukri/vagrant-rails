#!/usr/bin/env bash

cd /vagrant/
bundle install
rake db:migrate RAILS_ENV=development
