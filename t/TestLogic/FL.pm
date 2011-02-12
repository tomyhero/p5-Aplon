package TestLogic::FL;
use Mouse;
extends 'TestLogic::Base';
with 'TestLogic::Validator::FL';

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
