package TestModel::Model::SampleLogin;
use Mouse;
extends 'Aplon::Model::SampleLogin';

sub APLON_find_user {
    my $self = shift;
    my $args = shift;
    if($args->{email} eq 'tomohiro.teranishi@gmail.com' && $args->{password} eq '1111' ){
        return { name => 'tomohiro.teranishi' };
    }
    else {
        return ;
    }
}


__PACKAGE__->meta->make_immutable();

no Mouse;

1;
