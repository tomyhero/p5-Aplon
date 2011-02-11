package TestLogic::Error;
use Mouse;
extends 'App::Logic::Error';

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
        'dfv.user_id.missing' => 'user id is missing',
        'dfv.name.missing' => 'name is missing',
        'dfv.user_id.invalid' => 'user_id is invalid',
        'dfv.name.invalid' => 'name is invalid',
    }
}


__PACKAGE__->meta->make_immutable();

no Mouse;

1;
