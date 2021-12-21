package MojoCom;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  $self->plugin("OpenAPI" => {
      url => $self->home->rel_file("api.yaml"), schema => "v3"}
  );

}

1;
