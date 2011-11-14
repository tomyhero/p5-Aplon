package Aplon::Error::Role::LazyWay;
use Mouse::Role;

has 'error_message' => ( is => 'rw' , default => sub { {} } );

1;

=head1 NAME

Aplon::Error::Role::LazyWay - LazyWay extention role

=head1 SYNOPSIS


 App::Error;
 use Mouse;
 extends 'Aplon::Error';
 with 'Aplon::Error::Role::LazyWay';

 ;

=cut
