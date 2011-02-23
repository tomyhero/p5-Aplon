package TestModel::FL;
use Mouse;
extends 'TestModel::Base';
with 'TestModel::Validator::FL';

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
