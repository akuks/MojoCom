package MojoCom::ParamValidation;
use Mojo::Base -base, -signatures;

has 'validator';

has 'param_validation' => sub { die 'param_validation is required' };

sub validate_parameters ( $self ) {
    my $validator = $self;
    my $input = $self->validator->input;
    
    foreach ( keys %$input ) {
        $c->param_validation->{ $_ }->( $self->validator );
    }

}


1;