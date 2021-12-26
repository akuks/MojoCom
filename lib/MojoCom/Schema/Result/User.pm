use utf8;
package MojoCom::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoCom::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("user_id", { data_type => "integer", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-26 13:31:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wBSZmLUmiXeSrezIJ5xOTQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
