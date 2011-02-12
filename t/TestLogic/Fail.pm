package TestLogic::Fail;
use Mouse;
extends 'Aplon';

sub do_something {
    my $self = shift;
    my $id = shift;
    $self->abort({ message => 'hoge' });
}



__PACKAGE__->meta->make_immutable();

no Mouse;

1;
