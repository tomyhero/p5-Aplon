package App::Logic::Validator::Data::Form::Validator;
use Mouse::Role;
use Data::FormValidator;
use CGI::Carp;

sub profiles {
    my $self = shift;
    croak 'profiles() is ABSTRACT METHOD';
}

sub validate {
    my $self = shift;
    my $params = shift || {};
    my $name = shift;

    unless ($name) {
        ($name = (caller 1)[3]) =~ s/.*:://;
    }

    my $dfv = Data::FormValidator->new({},{ missing_optional_valid => 1 , msgs => &DFV_error_keys_handler() });
    my $profile = $self->profiles->{$name} or croak sprintf('profile "%s" not found.' ,$name );

    if( $profile->{constraint_methods} ){
        %{$profile->{constraint_methods}} = (%{$self->DFV_constraint_methods()},$profile->{constraint_methods});
    }
    else {
        $profile->{constraint_methods} = $self->DFV_constraint_methods();
    }

    if( $profile->{constraint_method_regexp_map} ){
        %{$profile->{constraint_method_regexp_map}} = (%{$self->DFV_constraint_method_regexp_map()},$profile->{constraint_method_regexp_map});
    }
    else {
        $profile->{constraint_method_regexp_map} = $self->DFV_constraint_method_regexp_map();
    }

    $dfv->check($params,$profile); 
}

sub abort_with {
    my $self = shift;
    my $dfv_results = shift ;
    my $args = { code => 'DFV_ERROR' }; 
   
    if($dfv_results->has_missing){
        $args->{missing} = $dfv_results->missing;
    }

    if($dfv_results->has_invalid){
        my $tmp = $dfv_results->invalid;
        my $invalid = {};
        for my $name (keys %$tmp){
            my $hash = {};
            for my $error (@{$tmp->{$name}}){
                $hash->{$error} = 1;
            }

            my @keys = ();
            for my $error (keys %$hash){
                push @keys,$error;
            }
            $invalid->{$name} = \@keys;
        }
        $args->{invalid} = $invalid;
    }
    $args->{error_keys} = $dfv_results->msgs;

    croak $self->error_class->new($args);
}


sub DFV_error_keys_handler {
    return sub {
        my ($dfv) = shift;
        my @msgs;
        for my $name($dfv->missing) {
            my $key = join '.', 'dfv', $name, 'missing';
            push @msgs ,$key;
        }
        for my $name($dfv->invalid) {
            my $hash = {};
            for my $reason(@{$dfv->invalid($name)}) {
                $reason = 'invalid' if !$reason || ref $reason;
                my $key = join '.', 'dfv', $name, $reason;
                $hash->{$key} = 1;
            }
            for(keys %$hash){
                push @msgs ,$_;
            }
        }
        \@msgs;
    }
}

sub DFV_constraint_methods { {} }
sub DFV_constraint_method_regexp_map { {} }

1;
