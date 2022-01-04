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

# Find user by unique user key
sub find_user_by_user_key ( $self, $user_key ) {
    return $self->find( {  user_key => $user_key } );
}

# Find user by user_id
sub find_user_by_id ( $self, $user_id ) {
    return $self->find( { user_id => $user_id } );
}

# Find user by user_key
sub find_user_by_uuid ( $self, $user_key ) {
    return $self->find( { user_key => $user_key } );
}

sub validate_user_cred ( $self, $email, $password ) {
    my $user;
    unless ( $user = $self->is_user_exists( $email ) ) {
        return 0
    }

    return $user;
}

sub get_full_name ( $self ) {
    return $self->first_name . ' ' . $_->last_name
}

1;