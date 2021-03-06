#!/usr/bin/env perl
# deploy.pl
#
# Written by Paul Mantz
#
# deploys the set of config files to their proper locations in a new
# home directory

use feature ':5.10';

use Env qw/ $HOME /;
use Cwd qw/abs_path/;
use Carp qw/ cluck croak /;

use DirHandle;
use File::Basename;

my %Overrides = ();

my $dir = abs_path dirname $0;
my $dh = DirHandle->new($dir);

sub set_up_symlink {

    my ($file) = @_;
    my $target = "$dir/$file";
    my $link   = "$HOME/.$file";

    say "symlink $link -> $target";
    unlink $link if (-e $link || -l $link);
    eval { symlink $target, $link; 1 }
      || do { croak "error: $!"; };
}

while (my $file = $dh->read) {

    # set up ignores
    next if $file =~ m{^\.};
    next if $file =~ m{~$};
    next if $file =~ m{^#};
    next if $file eq 'deploy.pl';

    # create the symlink if it passes the file checks
    set_up_symlink($file);
}
