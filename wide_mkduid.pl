#!/usr/bin/perl -w

#### client DUID generator for WIDE-DHCPv6
#### (C)2007 Jeffrey F. Blank <jfb@mtu.edu> / Michigan Technological University

use Config;
use Getopt::Std;
use POSIX;

$FN = getcwd() . '/dhcp6c_duid';

getopts('hm:t:', \%opts);

if ( defined($opts{h}) ) {
	&usage;
	exit 0;
}

if ( (defined($opts{m}) && $#ARGV >= 0) ||
	(!defined($opts{m}) && ($#ARGV != 0 || $ARGV[0] =~ /^-/o)) )
{
	&usage;
	exit 1;
}

if ( defined($opts{t}) ) {
	# timestamp specified; check its format (positive int or "now")
	$opts{t} = time() if $opts{t} eq 'now';
	if ( $opts{t} !~ /^\d+$/o ) {
		&usage;
		exit 1;
	}
	# LLT DUID type
	$duidtype = 1;
} else {
	# LL DUID type
	$duidtype = 3;
}

if ( defined($opts{m}) ) {
	# MAC address specified; use it instead of running 'ifconfig'
	$l = $opts{m};
} else {
	# interface name specified; run 'ifconfig' to retrieve its MAC address

	# start with a default of /sbin/ifconfig and update it if found in $PATH
	$ifconfig = '/sbin/ifconfig';
	@path = split(/:/o, $ENV{PATH});
	foreach(@path) {
		if ( -e "$_/ifconfig" ) {
			$ifconfig = "$_/ifconfig";
			last;
		}
	}

	# popen ifconfig command and read its output
	open(IFC, "$ifconfig $ARGV[0]|")
		or die "$0: can't popen $ifconfig: $!\n";
	if ( ! (@ifc=<IFC>) ) {
		# no need to print an error, as ifconfig probably already did
		exit ($? >> 8);
	}
	close(IFC);

	# we expect the MAC address to be preceded by "hwaddr" or "ether"
	# and colon-separated
	@ifc = grep { /(ether|hwaddr)\s*[0-9a-f]{1,2}(:[0-9a-f]{1,2}){5}/oi } @ifc;

	if ( $#ifc != 0 ) {
		print STDERR "$0: cannot decipher 'ifconfig' output\n";
		exit 3;
	}

	chomp ($l=shift @ifc);
	$l =~ s/^.*(hwaddr|ether)\s*//oi;
	$l =~ s/\s.*//oi;
}


# form the first two words of the DUID data: DUID type and link type.
# link-type is assumed to be ethernet(6)!

$duid_data = chr(0) . chr($duidtype) . chr(0) . chr(6);

if ( defined($opts{t}) ) {
	# create string from byte values, host byte order
	for ( $i=24; $i >= 0; $i -= 8 ) {
		$duid_data .= chr(($opts{t} >> $i) & 0xff);
	}
}

@mb = split(/:/o, $l);
foreach(@mb) {
	$duid_data .= chr(hex($_));
}

# first two bytes are DUID length, so figure that out
$duidlen = length($duid_data);

open(DUID, ">$FN") or die "$0: can't create $FN: $!\n";

# DUID length must be in network byte order, so check what perl thinks its
# byte order is. could use htons() from Net::Inet, but that's not included
# in at least some base installations.
if ( substr($Config{byteorder}, 0, 1) eq '1' ) {
	# reverse bytes on little-endian hosts
	printf DUID "%c%c", $duidlen & 0xff, $duidlen >> 8;
} else {
	# big-endian host; DUID length is already in network byte order
	printf DUID "%c%c", $duidlen >> 8, $duidlen & 0xff;
}

# DUID itself is written in host byte order
print DUID $duid_data;
close(DUID) or die "$0: error closing dhpc6c_duid: $!\n";

# print out DUID for potential use in server config file
$fmt = "successfully created $FN\nDUID is %02x" . (':%02x' x ($duidlen - 1)) . "\n";
@duid_bytes = ();
for ( $i=0; $i < $duidlen; $i++ ) {
	push @duid_bytes, ord(substr($duid_data, $i, 1));
}
printf $fmt, @duid_bytes;

### end main
##############

sub usage {
	print STDERR "usage:\t$0 [ -t <time> ] { -m <macaddr> | <ifname> }\n" .
	    "\tif specified, <macaddr> must be 6 colon-separated hex values\n" .
	    "\tif specified, <time> must be an integer or 'now'\n";
}

1;
