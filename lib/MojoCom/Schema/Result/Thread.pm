use utf8;
package MojoCom::Schema::Result::Thread;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoCom::Schema::Result::Thread

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

=head1 TABLE: C<threads>

=cut

__PACKAGE__->table("threads");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'threads_id_seq'

=head2 user_key

  data_type: 'uuid'
  is_nullable: 0
  size: 16

=head2 subject

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 body

  data_type: 'text'
  is_nullable: 0

=head2 slug

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 last_activity

  data_type: 'bigint'
  is_nullable: 1

=head2 created_at

  data_type: 'bigint'
  is_nullable: 0

=head2 updated_at

  data_type: 'bigint'
  is_nullable: 1

=head2 solution_reply_id

  data_type: 'bigint'
  is_nullable: 1

=head2 resolved_by

  data_type: 'uuid'
  is_nullable: 1
  size: 16

=head2 updated_by

  data_type: 'uuid'
  is_nullable: 1
  size: 16

=head2 locked_at

  data_type: 'bigint'
  is_nullable: 1

=head2 locked_by

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "threads_id_seq",
  },
  "user_key",
  { data_type => "uuid", is_nullable => 0, size => 16 },
  "subject",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "body",
  { data_type => "text", is_nullable => 0 },
  "slug",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "last_activity",
  { data_type => "bigint", is_nullable => 1 },
  "created_at",
  { data_type => "bigint", is_nullable => 0 },
  "updated_at",
  { data_type => "bigint", is_nullable => 1 },
  "solution_reply_id",
  { data_type => "bigint", is_nullable => 1 },
  "resolved_by",
  { data_type => "uuid", is_nullable => 1, size => 16 },
  "updated_by",
  { data_type => "uuid", is_nullable => 1, size => 16 },
  "locked_at",
  { data_type => "bigint", is_nullable => 1 },
  "locked_by",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-18 12:03:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pbHOh9T0xCCUmLlM1QJYMQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
