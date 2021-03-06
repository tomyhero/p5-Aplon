package Aplon::Validator::FormValidator::LazyWay;
use Mouse::Role;
use FormValidator::LazyWay;
use CGI::Carp();

sub profiles {
    my $self = shift;
    CGI::Carp::croak 'profiles() is ABSTRACT METHOD';
}

sub BUILD {
    my $self = shift;
    # compile.
    $self->FL_instance();
}

sub validate_with {
    my ($self,$params,$name,$stash) = @_;

    unless ($name) {
        ($name = (caller 1)[3]) =~ s/.*:://;
    }

    my $profile = (ref $name ? $name : $self->profiles->{$name}) or die 'profile not found:' . $name ;

    if($stash){
        $profile->{stash} = $stash;
    }

    my $form
        = $self->FL_instance->check( $params , $profile );

    return $form;
}

sub assert_with {
    my $self = shift;
    my $params = shift || {};
    my $name = shift;
    my $stash = shift;

    unless ($name) {
        ($name = (caller 1)[3]) =~ s/.*:://;
    }
    my $results = $self->validate_with($params,$name,$stash);
    if ($results->has_invalid or $results->has_missing) {
        $self->abort_with_result($results);
    }
    $self->{'__RESULTS' } = $results;

    return $results->valid;
}

sub abort_with {
    my $self = shift;
    my $error_name = shift ;
    my $args = shift || {};
    $args->{code} ||= 'ERROR';

    $args->{valid} = $self->{'__RESULTS'}->valid if $self->{'__RESULTS'};

    if ( $error_name ){
        $args->{custom_invalid} = ref $error_name ? $error_name : [$error_name];
        my $key = join '.', 'model','custom_invalid',$error_name ;
        $args->{error_keys} = [$key];
        CGI::Carp::croak $self->error_class->new($args);
    }
    else {
        CGI::Carp::croak $self->error_class->new($args);
    }

}

sub abort_with_result {
    my $self = shift;
    my $results = shift ;
    my $error_name = shift;
    my $args = { code => 'FL_ERROR' }; 

    $args->{valid} = $results->valid;

    if ( $error_name ){
        $args->{custom_invalid} = [$error_name];
        my $key = join '.', 'model','custom_invalid',$error_name ;
        $args->{error_keys} = [$key];
        CGI::Carp::croak $self->error_class->new($args);
    }

    if($results->has_missing){
        $args->{missing} = $results->missing;
    }

    if($results->has_invalid){
        my $invalid = {};
        for my $name ( keys %{$results->invalid}){
            $invalid->{$name} = [];
            for my $er ( keys %{$results->invalid->{$name}}){
                push @{$invalid->{$name}} , $er; 
            }
        }
        $args->{invalid} = $invalid;
    }

     $args->{error_keys} = $self->FL_error_keys_handler->($results);

     # lazyway error message
     $args->{error_message} = $results->error_message;

    CGI::Carp::croak $self->error_class->new($args);
}

sub FL_error_keys_handler {
    return sub {
        my ($dfv) = shift;
        my @msgs;
        for my $name(@{$dfv->missing}) {
            my $key = join '.', 'model', $name, 'missing';
            push @msgs ,$key;
        }

        for my $name(keys %{$dfv->invalid}) {
            for my $e (keys %{$dfv->invalid->{$name}} ){
                my $key = join '.', 'model', $name, 'invalid', $e;
                push @msgs ,$key;
            }
        }
        \@msgs;
    }
}


1;
