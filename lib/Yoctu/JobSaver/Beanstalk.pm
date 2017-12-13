package Yoctu::JobSaver::Beanstalk;

use strict;
# load the basic functions, thanks to exporter
use Yoctu::JobSaver::Base;

# Use the beanstalk lib
use Beanstalk::Client;

my $VERSION = "0.1";
sub Version { $VERSION; }

sub setServer {
    my ($self, $server) = @_;

    $self->{server} = $server if  defined($server);
    return($self->{server});
}

sub setTube {
    my ($self, $tube) = @_;

    $self->{tube} = $tube if defined($tube);
    return($self->{tube});
}

sub save {
    my ($self, $data) = @_;

    return "No Data given!" if ! $data;

    my $client = Beanstalk::Client->new(
        { 
            server       => $self->{server},
            default_tube => $self->{tube},
        }
    );

    $client->put(
        {
            data        => $self->encodeJson($data),
            priority    => 100,
            ttr         => 120,
            delay       => 0,
        }
    );

    return 1;
}

sub read {
    my ($self) = @_;

    my $client = Beanstalk::Client->new(
        { 
            server       => $self->{server},
            default_tube => $self->{tube},
        }
    );

    my $data = {};

    my $jobs_ready = $client->stats_tube($self->{tube});

    until($jobs_ready->current_jobs_ready eq 0){
        my $fetched_data = $client->reserve;
        $data->{$fetched_data->{id}} = $self->decodeJson($fetched_data->{data});
        $client->delete($fetched_data->{id});
        $jobs_ready = $client->stats_tube($self->{tube});
    }

    return $data;

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

