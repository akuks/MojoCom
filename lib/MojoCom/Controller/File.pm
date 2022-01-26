package MojoCom::Controller::File;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub image_post ( $c ) {

    return $c->render( json => { error => 'Image is required.' } ) if ( !$c->param('image') ) ;

    # Check for Valid Image Extension
    return $c->render( json => { error => 'Invalid image extension.' } )  
        if ( $c->param('image')->filename !~ /\.png$|\.jpg$|\.jpeg$/ ) ;

    my $image = $c->req->upload( 'image' );
    my $image_file = './public/image/articles/' . $c->param( 'image' )->filename;

    $image->move_to($image_file);
    
    $c->render( json => { 
        success => '1', 
        file => { 
            url => 'http://localhost.0x484c.com:3000/image/articles/' . $c->param( 'image' )->filename
        }
    });
}

1;