#!/usr/bin/env bash

set -e

# Start MySQL
echo "Starting MySQL Service"
/etc/init.d/mysql start
echo "MySQL started"

# Start Postgresql
echo "Starting Postgresql"
/etc/init.d/postgresql start
echo "Postgresql started"

echo "Setting up the application"

## SETUP
PERL_PATH="/usr/"
PERL_BINARY="$PERL_PATH/bin/perl"

BASE_DIR="/opt/MojoCom/"
LIB_PATH="$BASE_DIR/local/lib/perl5/"

MORBO_BINARY="$BASE_DIR/local/bin/morbo"

APP_BIN="$BASE_DIR/script/mojo_com"

TEMPLATE="$BASE_DIR/templates/"


echo "Export Perl Library Path"
export PERL5LIB=$LIB_PATH

# shellcheck disable=SC2028
echo "Starting the application\n"

carton exec $PERL_BINARY -I $LIB_PATH $MORBO_BINARY $APP_BIN -l http://*:3000

