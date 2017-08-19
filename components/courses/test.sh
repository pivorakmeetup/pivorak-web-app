#!/bin/bash

bundle install         || exit 1
bundle exec rspec spec || exit 1
