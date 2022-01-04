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
