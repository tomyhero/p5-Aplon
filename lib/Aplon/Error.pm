package Aplon::Error;
use Mouse;

has 'code' => ( is => 'rw' , default => 'ERROR' );
has 'missing' => (is => 'rw', default => sub { [] } );
has 'invalid' => (is => 'rw', default => sub { {} } );
has 'valid' => (is => 'rw', default => sub { {} } );
has 'custom_invalid' => (is => 'rw', default => sub { [] } );
has 'error_keys' => ( is => 'rw' , default => sub { [] } );

__PACKAGE__->meta->make_immutable();

no Mouse;

1;

=head1 NAME

Aplon::Error - Error Object.

=head1 SYNOPSIS

 my $error_obj = Aplon::Error->new({ 
    code => "ERROR_NAME",
    missing => ['ore_id'],
 });

=cut
