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

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 middle_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 url_blog

  data_type: 'text'
  is_nullable: 1

=head2 url_linkedin

  data_type: 'text'
  is_nullable: 1

=head2 url_github

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'bigint'
  is_nullable: 0

=head2 updated_at

  data_type: 'bigint'
  is_nullable: 1

=head2 user_key

  data_type: 'uuid'
  is_nullable: 1
  size: 16

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "middle_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url_blog",
  { data_type => "text", is_nullable => 1 },
  "url_linkedin",
  { data_type => "text", is_nullable => 1 },
  "url_github",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  { data_type => "bigint", is_nullable => 0 },
  "updated_at",
  { data_type => "bigint", is_nullable => 1 },
  "user_key",
  { data_type => "uuid", is_nullable => 1, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("users_email", ["email"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-26 22:41:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:72JE08MjR9Hkeh0pXfnBPw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
