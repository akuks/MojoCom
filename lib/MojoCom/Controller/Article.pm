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

    return $app->render( openapi => { error => $c->app->messages( 'invalid_params' ) } ) if $v->has_error;

    my $input = $v->input;
    my %options;

    foreach my $p ( keys %$input ) {
        $options{ $p } = $input->{ $p };
    }

    $options { created_at } = time();
    $options { user_key } = $c->req->headers->header('user');
    $options { slug } = get_slug( lc $c->param( 'title' ) );
    
    my $article = $c->app->dbh->resultset('Post')->create_or_update_article( \%options );

    my $output;

    if ( $article ) {
        $output->{ message } = $c->app->messages( 'article_create_success');
        $output->{ article } = $article ;
    }
    else {
        $output->{ error } = $c->app->messages( 'article_create_fail' )
    }

    $app->render( openapi => $output )
}

sub get_slug ( $title ) {
    
    $title =~ s/ +/-/g;

    return $title;
}

1;
