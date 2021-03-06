package MojoCom;
use Mojo::Base 'Mojolicious', -base, -signatures;

use MojoCom::Schema;
use Mojo::JWT;

use feature 'try';
no warnings qw(experimental::signatures);

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

    # Register Routes
    $self->plugin('MojoCom::Plugin::Routes::Home');
    $self->plugin('MojoCom::Plugin::Routes::Auth');
    $self->plugin('MojoCom::Plugin::Routes::Article');
    $self->plugin('MojoCom::Plugin::Routes::Upload');

    # Register Plugin
    $self->plugin('MojoCom::Plugin::Validation');
    $self->plugin('MojoCom::Plugin::DB');
    $self->plugin('MojoCom::Plugin::Message');

    $self->helper( dbh => sub { return $self->connect } );

    #JWT Helper
    $self->helper( jwt_encode => sub ( $c, $payload =  {} ) {
        return Mojo::JWT->new(
            claims  => $payload,
            secret  => $config->{secrets},
            expires => time + (3 * 30 * 3600)
        );
    });

    $self->helper( jwt_decode => sub ( $c, $jwt ) {
        return Mojo::JWT->new( secret => $config->{secrets} )->decode($jwt);
    });

    # Check if the form has been submitted from the browser
    # If not then return the request
    # $self->hook(
    #     before_dispatch => sub ( $c ) {
    #         my $browser = $c->req->headers->user_agent;

    #         if ( $browser =~ m/Postman|Curl/i and $self->mode ne 'development' ) {
    #             return $c->render( json => { message => 'You have successfully submitted the data' } )
    #         }

    #         if ( $c->req->url->path->to_route !~ m/api/ ) {
    #             return ;
    #         }

    #         # JWT Verification of requests
    #         if ( $c->req->url->path->to_route !~ m/login|user$|article/ ) {
    #             my $header = $c->req->headers->header('Authorization');
    #             my $uuid = $c->req->headers->header('user');

    #             my $jwt = ( split(/ +/, $header ) )[1];

    #             my $verification;

    #             try {
    #                 $verification = $c->app->jwt_decode( $jwt );
    #                 if ( $verification->{ id } ne $uuid ) {
    #                     return $c->render( openapi => json =>
    #                         {
    #                             status => 400,
    #                             error => $config->{ messages }->{ 'invalid_token' }
    #                         }
    #                     )
    #                 }
    #                 return $verification;
    #             }
    #             catch ( $e ) {
    #                 $c->app->log->debug( "Unable to get thing - $e" ) ;
    #                 return $c->render( openapi => json => { status => 400, error => 'Invalid Token' } )
    #             };
    #         }
    #     }
    # );

    # Workaround
    $self->hook(
        after_dispatch => sub ( $c ) {

            return if ( $c->req->url->path->to_route !~ m/api/ ) ;

            my $response = (  $c->res ) ?  $c->res->{ content }->asset->{content} : $c->response;
            my @query = split(/<style>/, $response );
            $c->render( openapi => json => Mojo::JSON::decode_json ( $query[0] ) )
        }
    );

}

1;
