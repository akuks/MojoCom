package MojoCom::Schema::ResultSet::Post;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_or_update_article ( $self, $options ) {
    my $article;

    eval {
        $article = $self->create(
            { %$options },
            { key => 'posts_slug_user_key' }
        );
    };
    return $@ ? 0 : $article;
}

sub get_article_by_slug( $self, $slug, $id ) {
    return $self->find({ slug => $slug, id => $id});
}


1;