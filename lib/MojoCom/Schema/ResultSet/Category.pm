package MojoCom::Schema::ResultSet::Category;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub get_category_by_name( $self, $category_name ) {
    return $self->find( { name => $category_name } );
}


1;