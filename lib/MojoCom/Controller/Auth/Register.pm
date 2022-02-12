package MojoCom::Controller::Auth::Register;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use MojoCom::ParamValidation;

use warnings;
use strict;

sub index ( $c ) {
    $c->render( template => 'auth/register' );
}

sub register_post ( $c ) {
    my $v = $c->validation;
    return $c->render( text => 'Invalid CSRF token!', status => 403)
        if $v->csrf_protect->has_error( 'csrf_token' );

    my @list = ['username', 'password', 'confirm_password']; 

    my $v = MojoCom::ParamValidation->new( 
        validator        => $c->validation, 
        param_validation => $c->param_validation ,
        param_list       => @list
    )->validate_parameters;

    return $c->render( json => { error => $c->app->messages( 'invalid_params' ) } ) if $v->has_error;

    $c->render ( json => { message => 'User registerd succesfully.' } );
}

# This is for the API.
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

    return $c->render ( openapi => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error ) ;

    if ( $c->app->dbh->resultset( 'User' )->is_user_exists( $c->param( 'username' ) ) ) {
        return $c->render( openapi => { error => 'User already exists.' } )
    }

    my %options = (
        email      => $c->param('username'),
        password   => $c->bcrypt($c->param('password')),
        created_at => time(),
        user_role  => 'contributor'
    );

    my $user = $c->app->dbh->resultset( 'User' )->create_update_user( \%options );

    if ( $user ) {
        $output = { message => 'User registered successfully' };
    }
    else {
        $output = { error => 'Failed to create user. Please contact support.' };
    }

    return $c->render( openapi => $output );
}



1;
