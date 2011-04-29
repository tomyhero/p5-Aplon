package Aplon::Validator::Simple;
use Mouse::Role;
use CGI::Carp;


sub abort_with {
    my $self = shift;
    my $args = shift || {};  # error obj args.
    $args->{code} ||= 'ERROR';

    my @error_keys = ();
    if($args->{custom_invalid} ){
        for(@{$args->{custom_invalid}}){
            my $key = join '.','model','custom_invalid',$_;
            push @error_keys,$key;
        }
    }

    
    if($args->{missing}){
        for(@{$args->{missing}}){
            my $key = join '.', 'model', $_, 'missing';
            push @error_keys,$key;
        }
    }

    if($args->{invalid}){ # invalid->{ name => [ 'too_long' ] } 
        for my $name (keys %{$args->{invalid}}){
            for my $e ( @{$args->{invalid}{$name}} ) {
                my $key = join '.', 'model', $name, 'invalid', $e;
                push @error_keys,$key;
            }
        }
    }

    $args->{error_keys} = \@error_keys;
    croak $self->error_class->new($args);

}


1;
