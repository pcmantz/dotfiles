#!/usr/bin/env perl
# deploy.pl
#
# Written by Paul Mantz
#
# deploys the set of config files to their proper locations in a new
# home directory

require 5.010_000;

use Cwd qw/abs_path/;
use DirHandle;
use File::Basename;

my %Overrides = ();

my $dir = abs_path dirname $0;
my $dh = DirHandle->new($dir);

sub set_up_symlink
{
    my ($target) = @_;
    my $link = %Overrides{$target} // "~/.$target";

    unlink $link if -e $link;
    eval { symlink $target, $link; }
      or do { croak "error: $!"; };
}

while ($dh->read) {

    # set up ignores
    next if $_ eq '.git';
    next if $_ eq 'deploy.pl';
    next if $_ =~ m{~$};
    next if $_ =~ m{^#};

    # create the symlink if it passes the file checks
    set_up_symlink($_);
}
