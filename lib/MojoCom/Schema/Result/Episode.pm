use utf8;
package MojoCom::Schema::Result::Episode;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoCom::Schema::Result::Episode

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

=head1 TABLE: C<episodes>

=cut

__PACKAGE__->table("episodes");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'episodes_id_seq'

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 user

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 created_at

  data_type: 'bigint'
  is_nullable: 0

=head2 updated_at

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "episodes_id_seq",
  },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "user",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "created_at",
  { data_type => "bigint", is_nullable => 0 },
  "updated_at",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 posts

Type: has_many

Related object: L<MojoCom::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts",
  "MojoCom::Schema::Result::Post",
  { "foreign.episode_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<MojoCom::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "MojoCom::Schema::Result::User",
  { user_key => "user" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-08 22:22:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:p6MWL0I/BICkIlEbb+mrDw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
