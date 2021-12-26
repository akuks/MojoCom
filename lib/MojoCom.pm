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

    # Workaround
    $self->hook(
        after_dispatch => sub ( $c ) {
            my $response = (  $c->res ) ?  $c->res->{ content }->asset->{content} : $c->response;
            my @query = split(/<style>/, $response );
            $c->render( openapi => json => Mojo::JSON::decode_json ( $query[0] ) )
        }
    );

}

1;
