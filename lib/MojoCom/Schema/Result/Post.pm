use utf8;
package MojoCom::Schema::Result::Post;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoCom::Schema::Result::Post

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

=head1 TABLE: C<posts>

=cut

__PACKAGE__->table("posts");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'posts_id_seq'

=head2 body

  data_type: 'text'
  is_nullable: 0

=head2 slug

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 created_at

  data_type: 'bigint'
  is_nullable: 0

=head2 updated_at

  data_type: 'bigint'
  is_nullable: 1

=head2 episode_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_key

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 status

  data_type: 'varchar'
  default_value: 'draft'
  is_nullable: 0
  size: 8

=head2 category

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cover_image

  data_type: 'text'
  is_nullable: 1

=head2 canonical_url

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "posts_id_seq",
  },
  "body",
  { data_type => "text", is_nullable => 0 },
  "slug",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "created_at",
  { data_type => "bigint", is_nullable => 0 },
  "updated_at",
  { data_type => "bigint", is_nullable => 1 },
  "episode_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "user_key",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "status",
  {
    data_type => "varchar",
    default_value => "draft",
    is_nullable => 0,
    size => 8,
  },
  "category",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cover_image",
  { data_type => "text", is_nullable => 1 },
  "canonical_url",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<posts_pkey_user_key>

=over 4

=item * L</id>

=item * L</user_key>

=back

=cut

__PACKAGE__->add_unique_constraint("posts_pkey_user_key", ["id", "user_key"]);

=head2 C<posts_slug_user_key>

=over 4

=item * L</user_key>

=item * L</slug>

=back

=cut

__PACKAGE__->add_unique_constraint("posts_slug_user_key", ["user_key", "slug"]);

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<MojoCom::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "MojoCom::Schema::Result::Category",
  { id => "category" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 comments

Type: has_many

Related object: L<MojoCom::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "MojoCom::Schema::Result::Comment",
  { "foreign.post_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 episode

Type: belongs_to

Related object: L<MojoCom::Schema::Result::Episode>

=cut

__PACKAGE__->belongs_to(
  "episode",
  "MojoCom::Schema::Result::Episode",
  { id => "episode_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 user_key

Type: belongs_to

Related object: L<MojoCom::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user_key",
  "MojoCom::Schema::Result::User",
  { user_key => "user_key" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-27 21:40:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Cm1r7DFES9v6RzSyi4di1Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->add_unique_constraint("posts_pkey", ["id"]);
1;
