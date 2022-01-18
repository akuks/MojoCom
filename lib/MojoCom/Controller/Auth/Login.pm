package MojoCom::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use strict;
use warnings;
use JSON;

sub login( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $email = $c->param( 'username' );
    my $password = $c->param( 'password' );

    my $user = $c->app->dbh->resultset( 'User')->validate_user_cred( $email, $password );

    unless ( $c->bcrypt_validate( $password || '', $user->password) ) {
        return $c->render(openapi => { error => 'Invalid username or password.', status => 400 } )
    }

    my $jwt = $c->app->jwt_encode(
        {
            id     => $user->user_key,
            secret => $c->app->plugin('NotYAMLConfig')->{api_key}
        }
    );

    my $output = {
        message => $c->messages( 'login_success' ),
        token   =>  $jwt->encode,
        expires =>  $jwt->expires
    } ;

    $app->render( openapi => json => $output )
}

sub profile ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $user = $c->app->dbh->resultset( 'User' )->find_user_by_uuid( $c->req->headers->header('user') );

    my @user = map {
        {
            email        => $_->email,
            first_name   => $_->first_name,
            middle_name  => $_->middle_name,
            last_name    => $_->last_name,
            url_blog     => $_->url_blog,
            url_linkedin => $_->url_linkedin,
            url_github   => $_->url_github,
            created_at   => $_->created_at,
            updated_at   => $_->updated_at,
            user_key     => $_->user_key
        }
    } $user;

    $app->render( openapi => { user => $user[0] } )
}

sub list ( $c ) {
    my $output = { message => $c->app->messages( 'login_success' ) } ;
    return $c->openapi->render( json => $output )
}

1;