package MojoCom::Plugin::Routes::Home;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ( $c, $app, $conf ) {
    my $r = $app->routes;

    $r->get( '/' )->to('Home#index');
    $r->get( '/get_category' )->to('Tag#show');

    return
} 

1;