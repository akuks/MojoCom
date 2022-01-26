package MojoCom::Plugin::Routes::Article;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ( $c, $app, $conf ) {
    my $r = $app->routes;
    
    my $ac_get = $r->get('/article');
    my $ac_post = $r->post('/article');
    
    # All the articles
    # $ac_get->get( '/' )->to('Article#index');
    $ac_get->get('/create')->to('Article#create_form');
    # $ac_get->get( '/:id' )->to('Article#show');
    
    # # Create 
    # $ac_post->('/create')->to('Article#create_post');
    # $ac_post->('/:id/update')->to('Article#update_post');

    return
} 

1;