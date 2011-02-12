package TestLogic::Validator::DFV;
use Mouse::Role;
with 'Aplon::Validator::Data::Form::Validator';
use Data::FormValidator::Constraints qw(:closures);


sub DFV_constraint_methods {
    my $self = shift;
    return +{
        status => qr/^[01]$/,
        name   => [
            FV_max_length(10),
            qr/^[a-zA-Z0-9_]+$/,
            qr/^[a-zA-Z_]+$/, # mulit invalid test
        ], 
    }
}

sub DFV_constraint_method_regexp_map {
    my $self = shift;
    return +{
        qr/_id$/ => qr/^[0-9]+$/,
    }
}


1;
