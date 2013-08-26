############################################################
###     Colored warnings and blocks of warnings          ###
############################################################
# NiceWarn.pm
# 
package Dev::NiceWarn;

use Exporter 'import';
@EXPORT_OK = qw(nwarn nblock);
use strict;
use warnings;
use Term::ANSIColor qw(RESET colorvalid colored);
my $PRE_WARN   = '>>> ';
my $DEFAULT_COLOUR  = 'GREEN';
my $TAG_COLOUR      = 'RED';

sub nwarn {
       my ($caller, $filename, $line) = caller;
       print STDERR colored ["$DEFAULT_COLOUR"], "@_ ";
       print STDERR colored ["$TAG_COLOUR"], "${PRE_WARN}$filename|$line\n"; 
}

sub nblock {
        my $color_arg = shift;
        # No arg -> off
        if ( not defined($color_arg) or $color_arg == 0 ) {
                $SIG{'__WARN__'} = undef;
                return;
        }

        # Arg Exists
        my $color = $DEFAULT_COLOUR;
        # Test and re-assign if arg is a valid colour
        if ( Term::ANSIColor::colorvalid($color_arg) ) {
                 print STDERR "$color_arg is VALID\n";
                 $color = $color_arg;
        }
        #print STDERR colored ["$color"], "BEGINNING NWBLOCK\n";
        $SIG{'__WARN__'} = sub { print STDERR colored ["$TAG_COLOUR"], $PRE_WARN, colored ["$color"], $_[0] };
}

1;
__END__

=pod

=head1 NAME
Dev::NiceWarn


=head1 AUTHOR
Author:       Ben Warren
Created:      Tue 11 Jun 2013  

=cut
