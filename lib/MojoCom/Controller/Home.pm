package MojoCom::Controller::Home;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub index ( $c ) {
    
    $c->render( template => 'home')
}


1;