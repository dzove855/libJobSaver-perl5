package Yoctu::JobSaver::Base;

use strict;

# Export all Functions
use base qw(Exporter);
@Yoctu::JobSaver::Base::EXPORT = qw(new encodeJson decodeJson);

# We need a json Parser
use JSON;

sub new {
    my $data = shift;
    my $self = {
    };

    bless $self, $data;
    return $self;    
}

sub setOpt {
    my ($self, $obj, $value) = @_;
    $self->{$obj} = $value if defined($obj) && defined($value);
    return($self->{$obj});
}

sub encodeJson {
    my ($self, $data) = @_;    
    my $json = JSON->new;

    return $json->encode($data);
}

sub decodeJson {
    my ($self, $data) = @_;
    my $json = JSON->new;

    return $json->decode($data);
}

1;

__END__

# This part should be read with perldoc
# see: https://perldoc.perl.org/perlpod.html
# or: man perlpod

=encoding utf-8

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHORS

=head1 COPYRIGHT

=head1 AVAILABILITY

=cut

