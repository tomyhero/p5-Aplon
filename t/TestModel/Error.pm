package TestModel::Error;
use Mouse;
extends 'Aplon::Error';

has 'error_message' => ( is => 'rw' , default => sub { {} } );

sub messages {
    my $self = shift;
    my @messages = ();
    my $master_messages = $self->ERROR_messages;
    for(@{$self->error_keys} ){
        if($master_messages->{$_}){
            push @messages,$master_messages->{$_} ;
        }
        else {
            push @messages,$_ ;
        }
    }
    return \@messages;
}

sub ERROR_messages {
    +{
        'model.user_id.missing' => 'user id is missing',
        'model.name.missing' => 'name is missing',
        'model.user_id.invalid' => 'user_id is invalid',
        'model.name.invalid' => 'name is invalid',
    }
}


__PACKAGE__->meta->make_immutable();

no Mouse;

1;
