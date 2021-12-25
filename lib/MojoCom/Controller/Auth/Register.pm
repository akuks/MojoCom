package MojoCom::Controller::Auth::Register;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use warnings;
use strict;

sub register ( $c ) {

    my $output = { message => 'User registered successfully' };
    $c->render( openapi => json => $output )
}

1;
