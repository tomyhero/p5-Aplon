package Aplon;
use Mouse;
use CGI::Carp;
our $VERSION = '0.01_01';

has 'error_class' => ( is => 'rw', default => 'Aplon::Error' );
has 'aplon_user' => ( is => 'rw', default => 'WEB_USER' );

sub BUILD {
    my $self = shift;
    Mouse::Util::load_class($self->error_class);
}

sub abort {
    my $self = shift;
    my $args = shift || {};

    my @error_keys = ();

    if($args->{missing}){
        for(@{$args->{missing}}){
            my $key = join '.', 'model', $_ , 'missing';
            push @error_keys,$key;
        }
    }

    if($args->{invalid}){
        for (@{$args->{invalid}}){
            for my $k (@{$_->{$_}}) {
                my $key = join '.', 'model', $_, 'invalid' , $k;
                push @error_keys,$key;
            }
        }
    }
    $args->{error_keys} = \@error_keys;
    croak $self->error_class->new($args);
}

sub abort_with {
    my $self = shift;
    my $error_name = shift ;
    my $args = { code => 'ERROR' };
    $args->{custom_invalid} = [$error_name];
    my $key = join '.', 'model','custom_invalid',$error_name ;
    $args->{error_keys} = [$key];
    croak $self->error_class->new($args);

}

__PACKAGE__->meta->make_immutable();

no Mouse;

1;

__END__

=head1 NAME

Aplon -

=head1 SYNOPSIS

 use Try::Tiny ; 
 my $model = Your::model::User->new();

 try {
    my $obj = $model->lookup(1234);
 } 
 catch {
    my $error_obj = $_ ; # Your::model::Error

 }
 finaly {

 };

=head1 DESCRIPTION

Aplon is base class of your Application model Class.

=head1 AUTHOR

Tomohiro Teranishi E<lt>tomohiro.teranishi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
