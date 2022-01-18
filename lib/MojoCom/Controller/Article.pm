package MojoCom::Controller::Article;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use MojoCom::ParamValidation;

# This action will render a template
sub create ( $c ) {
    my $app = $c->openapi->valid_input or return;

    my $v = MojoCom::ParamValidation->new( 
        validator        => $c->validation, 
        param_validation => $c->param_validation 
    )->validate_parameters;
  
    $app->render( openapi => { message => 'Article created successfully' } )
}

1;
