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
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_id_seq'

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
  default_value: uuid_generate_v4()
  is_nullable: 1
  size: 16

=head2 user_role

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "user_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
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
  {
    data_type => "uuid",
    default_value => \"uuid_generate_v4()",
    is_nullable => 1,
    size => 16,
  },
  "user_role",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 1, size => 255 },
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

=head2 C<users_user_key>

=over 4

=item * L</user_key>

=back

=cut

__PACKAGE__->add_unique_constraint("users_user_key", ["user_key"]);

=head1 RELATIONS

=head2 episodes

Type: has_many

Related object: L<MojoCom::Schema::Result::Episode>

=cut

__PACKAGE__->has_many(
  "episodes",
  "MojoCom::Schema::Result::Episode",
  { "foreign.user" => "self.user_key" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_role

Type: belongs_to

Related object: L<MojoCom::Schema::Result::UserRole>

=cut

__PACKAGE__->belongs_to(
  "user_role",
  "MojoCom::Schema::Result::UserRole",
  { role => "user_role" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-08 22:12:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vXfFoSpaJZjvcYoX/6tb3g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
