package MojoCom::Plugin::Message;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

use warnings;
use MojoCom::Schema;
use DBIx::Class();

use strict;

sub register ( $self, $app, $conf ) {

    my $config = $app->plugin('NotYAMLConfig');
    my $msg = $config->{ messages };

    $app->helper( messages => sub ( $c, $msg_type ) {
        return $msg->{ $msg_type } ? $msg->{ $msg_type } : '' ;
    });

    return
}

1;
