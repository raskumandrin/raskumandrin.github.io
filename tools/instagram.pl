#!/usr/bin/perl
use strict;

use FindBin;
use lib "$FindBin::Bin/lib";
use JSON;

my $url;

if ($ARGV[0]) {
    $url="https://api.instagram.com/oembed/?MAXWIDTH=720&url=http://instagr.am/p/$ARGV[0]/";
    
}
else {
    print "param: ./instagram.pl BnsGnNhDxyc\n";
    exit;
    
}

my $content = `curl -s "$url"`;
my $perl_hash_or_arrayref  = decode_json $content;

#use Data::Dumper;
#print Dumper($perl_hash_or_arrayref);

$perl_hash_or_arrayref->{html} =~ s/max-width:658px/max-width:720px/;
$perl_hash_or_arrayref->{html} =~ s/min-width:326px/min-width:280px!important/;

print $perl_hash_or_arrayref->{html}."\n";

#print $content;

__END__
#use JSON;
my $url="https://api.instagram.com/oembed/?url=http://instagr.am/p/BnsGnNhDxyc/&MAXWIDTH=720";
use LWP::Simple;
my $content = get($url);
die "Can't GET $url" if (! defined $content);