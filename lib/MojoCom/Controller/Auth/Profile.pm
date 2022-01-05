package MojoCom::Controller::Auth::Profile;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use warnings;
use strict;

sub update ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $v = $c->validation;
    my $output;

    # Parameter Validation Plugin
    foreach(qw/first_name middle_name last_name url_blog url_linkedin url_github/) {
        if ( $_ =~ m/_name$/ ) {
            $c->param_validation->{ 'name' }->( $v, $c->param( $_ ) );
        }
        elsif ( $_ =~ m/^url_/ ) {
            $c->param_validation->{ 'url' }->( $v, $c->param( $_ ) );
        }
        else {
            $c->param_validation->{ $_ }->( $v );
        }
    }

    return $c->render ( openapi => { error => $c->messages( 'invalid_params' ) } ) if ( $v->has_error ) ;

    # if ( $c->app->dbh->resultset( 'User' )->is_user_exists( $c->param( 'username' ) ) ) {
    #     return $c->render( openapi => { error => 'User already exists.' } )
    # }
    #
    # my %options = (
    #     email      => $c->param('username'),
    #     password   => $c->bcrypt($c->param('password')),
    #     created_at => time(),
    #     user_role  => 'contributor'
    # );
    #
    # #my $user = $c->app->dbh->resultset( 'User' )->create_update_user( \%options );
    #
    # if ( $user ) {
    #     $output = { message => 'User registered successfully' };
    # }
    # else {
    #     $output = { error => 'Failed to create user. Please contact support.' };
    # }

    return $c->render( openapi => $output );
}

1;
