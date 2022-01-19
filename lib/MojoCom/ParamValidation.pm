package MojoCom::ParamValidation;
use Mojo::Base -base, -signatures;

has 'validator';
has 'param_validation' => sub { die 'param_validation is required' };
has 'param_list' => sub { die 'param_list is required' };

sub validate_parameters ( $self ) {
    my $validator = $self;
    my $input = $self->param_list;
    
    foreach ( @$input ) {
        $self->param_validation->{ $_ }->( $self->validator );
    }

    return $self->validator;
}


1;