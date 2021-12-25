#!/usr/bin/env bash

set -e


echo "Setting up the application"

## SETUP
PERL_BINARY="perl"

BASE_DIR=`pwd`
LIB_PATH="$BASE_DIR/local/lib/perl5/"

MORBO_BINARY="$BASE_DIR/local/bin/morbo"

APP_BIN="$BASE_DIR/script/mojo_com"

TEMPLATE="$BASE_DIR/templates/"


echo "Export Perl Library Path"
export PERL5LIB=$LIB_PATH

# shellcheck disable=SC2028
echo "Starting the application\n"

carton exec $PERL_BINARY -I $LIB_PATH $MORBO_BINARY $APP_BIN -l http://*:3000

