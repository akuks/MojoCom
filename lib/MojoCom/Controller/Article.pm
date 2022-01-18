package MojoCom::Controller::Article;
use Mojo::Base 'Mojolicious::Controller', -signatures;

# This action will render a template
sub create ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $v = $c->validation;
  
    $app->render( openapi => json => 'Article created successfully' )
}

1;
