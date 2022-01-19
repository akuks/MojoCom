package MojoCom::Controller::Article;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use MojoCom::ParamValidation;

# This action will render a template
sub create ( $c ) {
    my $app = $c->openapi->valid_input or return;
    
    my @list = ['title', 'body', 'category']; # Required Parameters
    
    my $v = MojoCom::ParamValidation->new( 
        validator        => $c->validation, 
        param_validation => $c->param_validation ,
        param_list       => @list
    )->validate_parameters;

    return $app->render( openapi => { error => 'Invalid Input Parameters' } ) if $v->has_error;

    $app->render( openapi => { message => 'Article created successfully' } )
}

1;
