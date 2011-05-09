package TestModel::Base;
use Mouse;
extends 'Aplon';
has '+error_class' => ( is => 'rw', default => 'TestModel::Error' );

sub get_name {
    my $self = shift;
    my $args = shift;
    my $valid = $self->assert_with($args);
    return $valid->{name};
}

sub get_id {
    my $self = shift;
    my $id = shift ;
    my $valid = $self->assert_with({ user_id => $id });
    return $valid->{user_id};
}

__PACKAGE__->meta->make_immutable();

no Mouse;

1;
