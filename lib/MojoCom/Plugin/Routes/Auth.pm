package MojoCom::Plugin::Routes::Auth;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ( $c, $app, $conf ) {
    my $r = $app->routes;

    $r->get( '/login' )->to('Auth::Login#index');
    $r->get( '/signup' )->to('Auth::Register#index');

    return
} 

1;