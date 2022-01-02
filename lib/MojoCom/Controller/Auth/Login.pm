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

    my $output = {
        message => 'Login Successful',
        token   =>  $c->app->jwt_encode(
            {
                id => $user->id,
                secret => $c->app->plugin('NotYAMLConfig')->{api_key}
            }
        )
    } ;

    $app->render( openapi => json => $output )
}

sub list ( $c ) {
    my $output = { message => 'Login Successful' } ;
    return $c->openapi->render( json => $output )
}

1;