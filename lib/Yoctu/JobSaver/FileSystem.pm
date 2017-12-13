package Yoctu::JobSaver::FileSystem;

use strict;

# load the basic functions, thanks to exporter
use Yoctu::JobSaver::Base;

# we need slurp, because it's nice
use File::Slurp;

my $VERSION = "0.1";
sub Version { $VERSION; }

sub setDir {
    my ($self, $value) = @_;

    $value =~ s|/$||d;

    mkdir $value if ! -d $value;
    return "Cannot create Dir!" if ! -d $value; 

    $self->{dir} = $value if  defined($value);
    return($self->{dir});
}

sub getDir {
    my ($self) = @_;

    return($self->{dir});
}

sub save {
    my ($self, $data) = @_;

    return "No Data given!" if ! $data;

    # Default id should always be 0, because there's an icrement
    my $id = 0;
    
    # open the dir, and get thes files 
    opendir my $dir, $self->getDir() or return "Cannot open Dir!";
    my @files = readdir $dir;
    closedir $dir;

    @files = reverse @files;

    $id = $files[0] if $files[0] gt $id or $files[0] eq $id;

    # Increment id
    $id++;

    open(my $file, '>', $self->getDir() . "/" . $id)
        or return "Cannot open File!";

    print $file $self->encodeJson($data);

    return 1;
}

sub read {
    my ($self) = @_;

    my $data = {};
    
    # glob work here better then readdir
    my @files = glob ( $self->getDir . "/*");
    for (@files) { s|^.*/||g; }
    
    foreach my $file (@files) {
        my $content = read_file($self->getDir . "/" . $file);
        chomp($content);
        $data->{$file} = $self->decodeJson($content);
        unlink($self->getDir . "/" . $file)
    }

    return $data if @files; 
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

