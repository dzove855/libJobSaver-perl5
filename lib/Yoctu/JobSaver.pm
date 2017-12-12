package Yoctu::JobSaver;

# A good package:
# Examples
# Good description what the need is for
# and it need to work

# Examples: 
# Yoctu/
#    NAME.pm            <-- Should contain a global loader, see require
#    NAME/              
#       SUB.pm          <-- Should be a sub module


use strict;
use base qw(Exporter);
@Yoctu::JobSaver::EXPORT = qw(new getData);

my $VERSION = "0.1";
sub Version { $VERSION; }

sub new {
    my $slackfile = shift;
    my $self = {
        token => shift,
        filename => shift,
    filepath => "/tmp",
        fileid => shift,
        channels => shift
    };

    bless $self, $slackfile;
    return $self;    
}

sub getData {
    return "haha";
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

