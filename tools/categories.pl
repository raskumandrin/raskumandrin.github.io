#!/usr/bin/perl
use strict;



foreach my $lang (qw(ru en)) {
    foreach my $type (qw(categories countries tags)) {
        open my $fh,'<',"../_data/$lang/$type.csv";
        my ($layout,$lpath);
        if ($type eq 'categories') {
            $layout = 'category';
        }
        elsif ($type eq 'countries') {
            $layout = 'country';
        }
        elsif ($type eq 'tags') {
            $layout = 'tag';
        };
        
        if ($lang eq 'ru') {
            $lpath = ''
        }
        elsif ($lang eq 'en') {
            $lpath = 'en/';
        }
        
        <$fh>;
        while (my $line = <$fh>) {
            chomp $line;
            next unless $line;
            my ($label,$title) = ( $line =~ /^([^,]+),(.+)$/ );
            next unless $label;
            next unless $title;
            my $path = "${lpath}${label}.html";
            my $data =<<"EOF";
---
layout: category
$layout: $label
head: $title
---

EOF
#print "$data\n======= $path\n";

        
        open my $fh2,'>',"../$path";
        print $fh2 $data;
        close $fh2;

        }
        close $fh;
        
    }
}

