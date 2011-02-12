package TestLogic::Base;
use Mouse;
extends 'Aplon';
has '+error_class' => ( is => 'rw', default => 'TestLogic::Error' );

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
