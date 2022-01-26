package MojoCom::Plugin::Routes::Upload;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ( $c, $app, $conf ) {
    
    my $r = $app->routes;
    
    my $file_get = $r->get('/upload');
    my $file_post = $r->post('/upload');

    $file_post->post('/image')->to('File#image_post');

    return
}

1;