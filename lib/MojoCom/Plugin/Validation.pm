package MojoCom::Plugin::Validation;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
use Email::Valid;

use warnings;
use strict;

sub register ( $c, $app, $conf ) {

    $app->helper( param_validation => sub ( $c ) {
        return state $param_validation = {
            username => sub( $v, $email ) {
                $v->required('username')->like(Email::Valid->address($email))
            },
            password => sub( $v ) {
                $v->required('password')->like(qr/^[a-zA-Z0-9]+$/);
                $v->required('confirm_password')->equal_to('password') if $v->required('password')->is_valid;
            },
            name     => sub( $v, $name ) {
                if ($name =~ m/^first_|^last_/) {
                    $v->required( $name )->like(qr/^[a-zA-Z]/)
                }
                else {
                    $v->optional( $name )->like(qr/^$|^[a-zA-Z]/);
                }
            },
            url      => sub ( $v, $url ) {
                $v->optional( $url )->like(qr/^$|^(?:(?:https?|s?))/);
            },
            title      => sub ( $v ) {
                $v->required( 'title' )->like(qr/^[a-zA-Z0-9~@#$^*()_+=[\]{}|\\,.?: -]*$/);
            },
            body       => sub ( $v ) {
                $v->required( 'body' )->like(qr/./);
            },
            canonical_url      => sub ( $v ) {
                $v->optional( 'canonical_url' )->like(qr/^$|^(?:(?:https?|s?))/);
            },
            image         => sub ( $v ) {
                $v->optional( 'image' )->like(qr/^$|\.png$|\.jpg$|\.jpeg$|\.gif$/);
            },
            category      => sub ( $v ) {
                $v->required( 'category' )->like(qr/^[0-9]$/);
            }
        }
    });
    return
}

1;