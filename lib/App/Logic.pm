package App::Logic;
use Mouse;
use CGI::Carp;
our $VERSION = '0.01';

has 'error_class' => ( is => 'rw', default => 'App::Logic::Error' );
has 'logic_user' => ( is => 'rw', default => 'WEB_USER' );

sub BUILD {
    my $self = shift;
    Mouse::Util::load_class($self->error_class);
}

sub abort {
    my $self = shift;
    my $args = shift || {};
    croak $self->error_class->new($args);
}

__PACKAGE__->meta->make_immutable();

no Mouse;

1;

__END__

=head1 NAME

App::Logic -

=head1 SYNOPSIS

 use Try::Tiny ; 
 my $logic = Your::Logic::User->new();

 try {
    my $obj = $logic->lookup(1234);
 } 
 catch {
    my $error_obj = $_ ; # Your::Logic::Error

 }
 finaly {

 };

=head1 DESCRIPTION

App::Logic is base class of your Application Logic Class.

=head1 AUTHOR

Tomohiro Teranishi E<lt>tomohiro.teranishi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
