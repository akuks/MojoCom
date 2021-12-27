package MojoCom::Controller::Auth::Register;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use warnings;
use strict;

sub register ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $v = $c->validation;
    my $output;

    # Parameter Validation Plugin
    foreach(qw/username password/) {
        if ( $_ eq 'username') {
            $c->param_validation->{ $_ }->( $v, $c->param( 'username' ) );
        }
        else {
            $c->param_validation->{ $_ }->( $v );
        }
    }

    print Data::Dumper::Dumper( $c->req->headers->user_agent );
    return $c->render ( openapi => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error ) ;


    $output = { message => 'User registered successfully' };


    return $c->render( openapi => $output );
}

1;
