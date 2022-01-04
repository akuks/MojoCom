use utf8;
package MojoCom::Schema::Result::UserRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoCom::Schema::Result::UserRole

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

=head1 TABLE: C<user_roles>

=cut

__PACKAGE__->table("user_roles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'user_roles_id_seq'

=head2 role

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "user_roles_id_seq",
  },
  "role",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_roles_unique>

=over 4

=item * L</role>

=back

=cut

__PACKAGE__->add_unique_constraint("user_roles_unique", ["role"]);

=head1 RELATIONS

=head2 users

Type: has_many

Related object: L<MojoCom::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "MojoCom::Schema::Result::User",
  { "foreign.user_role" => "self.role" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-04 21:43:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5ZeJIypO+VAH7AM2/sML1Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
