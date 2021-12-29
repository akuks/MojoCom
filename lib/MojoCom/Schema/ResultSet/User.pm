package MojoCom::Schema::ResultSet::User;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_update_user ( $self, $options ) {
    my $user;

    eval {
        $user = $self->update_or_create(
            { %$options },
            { key => 'users_email' }
        );
    };

    return $@ ? 0 : $user;
}

# If user exists
sub is_user_exists ( $self, $email ) {
    return $self->find( {  email => $email } );
}

1;