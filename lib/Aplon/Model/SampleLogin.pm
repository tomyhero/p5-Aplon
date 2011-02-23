package Aplon::Model::SampleLogin;
use Mouse;
use CGI::Carp;
extends 'Aplon';

sub login {
    my $self = shift;
    my $args = shift || {};
    my $opts = shift || {};

    croak 'require callback' unless ref $opts->{callback};

    my @missing = ();
    for(qw/password email/){
        unless($args->{$_}){
            push @missing , $_;
        }
    }

    if(scalar @missing ){
        $self->abort({missing => \@missing});    
    }

    if( my $user  = $self->APLON_find_user($args) ) {
        if($opts->{callback}->($user) ){
            return $user;
        }
        else {
            $self->abort_with('do_login_failed');
        }
    }
    else {
        $self->abort_with('login_failed');
    }
}

sub APLON_find_user { croak 'implement APLON_find_user' }



__PACKAGE__->meta->make_immutable();

no Mouse;

1;
