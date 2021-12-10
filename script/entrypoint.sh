#!/usr/bin/env bash

set -e

# Install Mojolicious
MORBO="/usr/local/bin/morbo"
APP_BIN="/opt/MojoCom/script/mojo_com"

# Start the Backend Application
$MORBO $APP_BIN