package MojoCom::Controller::Auth::Profile;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use warnings;
use strict;

sub update ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $v = $c->validation;
    my $output;

    my %options;

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

        $options{ $_ } = $c->param( $_ );
    }

    return $c->render ( openapi => { error => $c->messages( 'invalid_params' ) } ) if ( $v->has_error ) ;

    $options{ updated_at } = time();

    my $uuid = $c->req->headers->header('user');
    my $user = $c->app->dbh->resultset( 'User' )->find_user_by_user_key( $uuid );

    if ( $user ) {
        eval {
            $user->update({ %options });
        };
        $output = ( ! $@ ) ?
            { message => $c->app->messages( 'user_update' ) } :
            { error => $c->app->messages( 'user_update_fail' ) };
    }
    else {
        $output = { error => $c->app->messages( 'user_update_fail' ) }
    }

    return $c->render( openapi => $output );
}

1;
