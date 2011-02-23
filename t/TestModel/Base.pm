package TestModel::Base;
use Mouse;
extends 'Aplon';
has '+error_class' => ( is => 'rw', default => 'TestModel::Error' );

sub get_name {
    my $self = shift;
    my $args = shift;
    my $results = $self->assert_with($args);
    if($results->valid->{status}){
        return $results->valid->{name};
    } 
    else {
        $self->abort_with($results,'not_found');
    }
}

sub get_id {
    my $self = shift;
    my $id = shift ;
    my $results = $self->assert_with({ user_id => $id });
    return $results->valid->{user_id};
}

__PACKAGE__->meta->make_immutable();

no Mouse;

1;
