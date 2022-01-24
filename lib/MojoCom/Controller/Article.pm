package MojoCom::Controller::Article;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use MojoCom::ParamValidation;

# Required Parameters
my @list = ['title', 'body', 'category']; 

# This action will render a template
sub create ( $c ) {
    my $app = $c->openapi->valid_input or return;
    
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
    $options { slug } = $c->param( 'slug' ) ? get_slug( lc $c->param( 'slug' ) ) :  get_slug( lc $c->param( 'title' ) ) ;
    
    my $article = $c->app->dbh->resultset('Post')->create_or_update_article( \%options );

    my $output;

    if ( $article ) {
        $output->{ message } = $c->app->messages( 'article_create_success');
        $output->{ article } = get_article_details( $article ); ;
    }
    else {
        $output->{ error } = $c->app->messages( 'article_create_fail' )
    }

    $app->render( openapi => $output )
}

# Updating the article
sub edit ( $c ) {
    $c->openapi->valid_input or return;
    
    my $v = MojoCom::ParamValidation->new( 
        validator        => $c->validation, 
        param_validation => $c->param_validation ,
        param_list       => @list
    )->validate_parameters;

    return $c->render( openapi => { error => $c->app->messages( 'invalid_params' ) } ) if $v->has_error;

    my $input = $v->input;
    my %options;

    foreach my $p ( keys %$input ) {
        $options{ $p } = $input->{ $p };
    }

    $options { updated_at } = time();
    $options { user_key } = $c->req->headers->header('user');

    my $article = $c->app->dbh->resultset('Post')->create_or_update_article( \%options );

    my $output;

    if ( $article ) {
        $output->{ message } = $c->app->messages( 'article_update_success');
        $output->{ article } = get_article_details( $article ); ;
    }
    else {
        $output->{ error } = $c->app->messages( 'article_create_fail' )
    }

    $c->render( openapi => $output )
}

sub show ( $c ) {
    my ($slug, $id) = $c->param( 'slug' ) =~ /(.*)-(.*)/;

    my $article = $c->app->dbh->resultset( 'Post' )->get_article_by_slug( $slug, $id );

    return $c->render( openapi => { error => $c->app->messages( 'article_not_found' ), status => 400 } ) if ( !$article );

    my @article_details = get_article_details( $article );

    $c->render( openapi => $article_details[0] );
}

sub get_slug ( $title ) {
    
    $title =~ s/ +/-/g;

    return $title;
}

sub get_article_details ( $article ) {
    my @article_details = map {
        {  
            id    => $_->id,
            title => $_->title,
            slug => $_->slug,
            body => $_->body,
            created_at => $_->created_at,
            updated_at => $_->updated_at,
            user => { 
                key => $_->user_key->user_key,
                name => $_->user_key->first_name. ' ' . $_->user_key->last_name
            },
            episodes => $_->episode_id ? $_->episode_id : '',
            status => $_->status,
            category => $_->category,
            image => $_->cover_image,
            canonical_url => $_->canonical_url
        }
    } $article;

    return @article_details
}

1;
