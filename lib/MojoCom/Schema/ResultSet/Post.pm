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
    print $@;
    return $@ ? 0 : $article;
}


1;