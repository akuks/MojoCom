package MojoCom::Plugin::Validation;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
use Email::Valid;

use warnings;
use strict;

sub register ( $c, $app, $conf ) {

    $app->helper( param_validation => sub ( $c ) {
        return state $param_validation = {
            username => sub ( $v, $email ) {
                $v->required( 'username' )->like( Email::Valid->address( $email ) )
            },
            password => sub ( $v ) {
                $v->required( 'password' )->like( qr/^[a-zA-Z0-9]+$/ );
                $v->required( 'confirm_password' )->equal_to( 'password' ) if $v->required( 'password' )->is_valid;
            }
        }
    });
    return
}

1;