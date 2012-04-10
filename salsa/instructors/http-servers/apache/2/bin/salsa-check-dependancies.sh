#!/bin/bash

# checking php module
#if [ -z `dpkg --get-selections | grep libapache2-mod-php5 | grep install` ]; then
#    echo "apache not installed"
#fi

# checking for base apache2 install
if [ -z `dpkg --get-selections | grep apache2 | grep install` ]; then
    echo "apache not installed"
fi
