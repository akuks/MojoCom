package MojoCom::Plugin::DB;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

use warnings;
use MojoCom::Schema;
use DBIx::Class();

use strict;

sub register ( $self, $app, $conf ) {

    my $config = $app->plugin('NotYAMLConfig');
    my $db_config = $config->{ database }->{ $app->mode };

    $app->helper( connect => sub ( $c ) {
        my $dbh = $config->{ database }->{ schema }->connect(
            $db_config->{ dsn },
            $db_config->{ username },
            $db_config->{ password }
        );

        return $dbh;
    });

    return
}

1;
