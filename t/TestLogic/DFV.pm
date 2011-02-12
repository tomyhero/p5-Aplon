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
sub get_name {
    my $self = shift;
    my $args = shift;
    my $results = $self->validate($args);
    if ($results->has_invalid or $results->has_missing) {
        $self->abort_with($results);
    }
    else {
        if($results->valid->{status}){
            return $results->valid->{name};
        }
        else {
            $self->abort_with('not_found');
        }
    }
}

sub get_id {
    my $self = shift;
    my $id = shift ;
    my $results = $self->validate({ user_id => $id });
   
    if ($results->has_invalid or $results->has_missing) {
        $self->abort_with($results);
    }
    else {
        $results->valid->{user_id};
    }

}



__PACKAGE__->meta->make_immutable();

no Mouse;

1;
