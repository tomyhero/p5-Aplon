package App::Logic::Error;
use Mouse;

has 'code' => ( is => 'rw' , default => 'ERROR' );
has 'missing' => (is => 'rw', default => sub { [] } );
has 'invalid' => (is => 'rw', default => sub { {} } );
has 'error_keys' => ( is => 'rw' , default => sub { [] } );

__PACKAGE__->meta->make_immutable();

no Mouse;

1;

=head1 NAME

App::Logic::Error - Error Object.

=head1 SYNOPSIS

 my $error_obj = App::Logic::Error->new({ 
    code => "ERROR_NAME",
    missing => ['ore_id'],
 });

=cut
