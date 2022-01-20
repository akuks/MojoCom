package MojoCom::Schema::ResultSet::Post;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_article ( $self, $options ) {
    my $article;

    eval {
        $article = $self->create(
            { %$options }
        );
    };
    print $@;
    return $@ ? 0 : $article;
}


1;