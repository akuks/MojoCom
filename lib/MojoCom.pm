package MojoCom;
use Mojo::Base 'Mojolicious', -signatures;
use MojoCom::Plugin::DB;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  $self->plugin( 'AutoReload' );

  # Configure the application
  $self->secrets($config->{secrets});

  $self->plugin("OpenAPI" => {
      url => $self->home->rel_file("api.yaml"), schema => "v3"
  });

  $self->helper( dbh => $self->plugin('MojoCom::Plugin::DB') );

  # $self->plugin(
  #     OpenAPI => {
  #         renderer => sub {
  #           my ($c, $data) = @_;
  #           return ($data);
  #         }
  #     }
  # );

}

sub return_response ( $self, $c, $output ) {
    $c->render( openapi => json => $output )
}

1;
