package MojoCom::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use strict;
use warnings;
use JSON;

sub login( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $output = { message => 'Login Successful' } ;

    $app->render( openapi => json => $output )
}

sub list ( $c ) {
    my $output = { message => 'Login Successful' } ;
    return $c->openapi->render( json => $output )
}

1;