package TestLogic::DFV;
use Mouse;
extends 'TestLogic::Base';
with 'TestLogic::Validator::DFV';


sub profiles {
    my $self = shift;
    return {
        get_id => {
            required => [qw/user_id/],
        },
        get_name => {
            required => [qw/name/],
            optional => [qw/status/],
        }
    }
}
__PACKAGE__->meta->make_immutable();

no Mouse;

1;
