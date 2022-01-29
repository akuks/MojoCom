package MojoCom::Controller::Tag;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::JSON;

sub show ( $c ) {
    my $tag = $c->app->dbh->resultset( 'Category' )->find({ name => $c->param('value') });

    $c->render( json => { value => $tag ? $tag->name : 0 } );
}

1;