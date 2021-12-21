package MojoCom::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use strict;
use warnings;

sub login( $c ) {
    $c->openapi->valid_input or return;

    print Data::Dumper::Dumper( $c->req->json );

    $c->render( openapi => $c->req->json )
}

1;