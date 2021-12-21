package MojoCom::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use strict;
use warnings;
use JSON;

sub login( $c ) {
    $c->openapi->valid_input or return;

    my $output = { message => 'Login Successful' } ;

    return $c->render( json => $output )
}

1;