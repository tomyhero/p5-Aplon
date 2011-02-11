package TestLogic::Base;
use Mouse;
extends 'App::Logic';
has '+error_class' => ( is => 'rw', default => 'TestLogic::Error' );

__PACKAGE__->meta->make_immutable();

no Mouse;

1;
