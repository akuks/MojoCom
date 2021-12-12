#!/usr/bin/env bash

set -e

echo "Setting up"

## SETUP
MORBO="/usr/local/bin/morbo"
APP_BIN="/opt/MojoCom/script/mojo_com"
FE_APP="/opt/MojoCom/app/"

## Change Directory
echo "Change the directory"
cd $FE_APP
#
#which yarn

## Start the Frontend
echo "Starting the Application"
yarn install

yarn dev &

ls -lhrt
pwd

# Start the Backend Application
$MORBO $APP_BIN
#/usr/local/bin/morbo /opt/MojoCom/script/mojo_com