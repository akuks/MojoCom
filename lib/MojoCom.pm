package MojoCom;
use Mojo::Base 'Mojolicious', -signatures;

use MojoCom::Schema;
# This method will run once at server start
sub startup ($self) {

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    $self->plugin( 'AutoReload' );
    $self->plugin('Bcrypt');

    # Configure the application
    $self->secrets($config->{secrets});

    $self->plugin("OpenAPI" => {
        url => $self->home->rel_file("api.yaml"), schema => "v3"
    });


    # Register Plugin
    $self->plugin('MojoCom::Plugin::Validation');
    $self->plugin('MojoCom::Plugin::DB');

    $self->helper( dbh => sub { return $self->connect } );

    # Check if the form has been submitted from the browser
    # If not then return the request
    $self->hook(
        before_dispatch => sub ( $c ) {
            my $browser = $c->req->headers->user_agent;
            if ( $browser =~ m/Postman|Curl/i and $self->mode ne 'development' ) {
                return $c->render( json => { message => 'You have successfully submitted the data' } )
            }
        }
    );

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
