#!/usr/bin/perl
use strict;

use FindBin;
use lib "$FindBin::Bin/.mojo/lib";

use Data;


`rm $FindBin::Bin/_posts/*`;
`rm $FindBin::Bin/_data/ru/*`;
`rm $FindBin::Bin/_data/en/*`;

my $fh;

open($fh, ">:utf8", "$FindBin::Bin/_data/en/countries.csv");
print $fh "label,title\n";
print $fh "$_,$Data::countries->{$_}{en}\n" foreach sort keys %$Data::countries;
close $fh;

open($fh, ">:utf8", "$FindBin::Bin/_data/ru/countries.csv");
print $fh "label,title\n";
print $fh "$_,$Data::countries->{$_}{ru}\n" foreach sort keys %$Data::countries;
close $fh;



open($fh, ">:utf8", "$FindBin::Bin/_data/en/categories.csv");
print $fh "label,title\n";
print $fh "$_,$Data::rubrics->{$_}{en}\n" foreach sort keys %$Data::rubrics;
close $fh;

open($fh, ">:utf8", "$FindBin::Bin/_data/ru/categories.csv");
print $fh "label,title\n";
print $fh "$_,$Data::rubrics->{$_}{ru}\n" foreach sort keys %$Data::rubrics;
close $fh;



open($fh, ">:utf8", "$FindBin::Bin/_data/en/tags.csv");
print $fh "label,title\n";
print $fh "$_,$Data::tags->{$_}{en}\n" foreach sort keys %$Data::tags;
close $fh;

open($fh, ">:utf8", "$FindBin::Bin/_data/ru/tags.csv");
print $fh "label,title\n";
print $fh "$_,$Data::tags->{$_}{ru}\n" foreach sort keys %$Data::tags;
close $fh;


foreach my $p (@$Data::contents) {
    if ($p->{url} eq 'spb-baths') {
        open($fh, ">:utf8", "$FindBin::Bin/_posts/$p->{date}-$p->{url}.html");
        open(my $fh1, "<:utf8", "$FindBin::Bin/.mojo/2019-03-28-spb-baths.html");
        while (<$fh1>) {
            print $fh $_;
        }
        close $fh1;
        close $fh;
        next;
    }
    
    
    open($fh, ">:utf8", "$FindBin::Bin/_posts/$p->{date}-$p->{url}.html");
    
$p->{poster_ru} =~ s/^\s*/    /gm;    

#        js   => { fresco => 1, plyr => 1, },

my $js = '';
if ($p->{js} and ref($p->{js}) eq 'HASH') {
    $js = 'js: ['.join(',',sort keys(%{$p->{js}}))."]\n";
}

my $extra = '';
$extra .= "og_image: $p->{og_image_ru}\n" if $p->{og_image_ru};
$extra .= "og_title: $p->{og_title_ru}\n" if $p->{og_title_ru};
$extra .= "og_description: \"$p->{og_description_ru}\"\n" if $p->{og_description_ru};
$extra .= "cuttitle: \"$p->{cuttitle_ru}\"\n" if $p->{cuttitle_ru};
$extra .= "keywords: $p->{og_image_ru}\n" if $p->{keywords_ru};
$extra .= "categories: $p->{rubric}\n" if $p->{rubric};
$extra .= "country: $p->{country}\n" if $p->{country};
$extra .= "tags: [$p->{tags}]\n" if $p->{tags};
$extra .= $js;

    print $fh <<"EOF";
---
url: $p->{url}
title: $p->{title_ru}
excerpt: |
$p->{poster_ru}
$extra
---
EOF
    
    my ($year) = ( $p->{date} =~ /^(\d{4})/ );
    
    open(my $fh1, "<:utf8", "$FindBin::Bin/.mojo/templates/$year/$p->{date}-$p->{url}-ru.html.ep");
    while (<$fh1>) {
        print $fh $_;
    }
    close $fh1;
    close $fh;
    
    if ($p->{title_en}) {
        
        $p->{poster_en} =~ s/^\s*/    /gm;    


        my $extra = '';
        $extra .= "og_image: $p->{og_image_en}\n" if $p->{og_image_en};
        $extra .= "og_title: $p->{og_title_ru}\n" if $p->{og_title_en};
        $extra .= "og_description: $p->{og_description_en}\n" if $p->{og_description_en};
        $extra .= "cuttitle: $p->{cuttitle_en}\n" if $p->{cuttitle_en};
        $extra .= "keywords: $p->{og_image_en}\n" if $p->{keywords_en};
        $extra .= "categories: $p->{rubric}\n" if $p->{rubric};
        $extra .= "country: $p->{country}\n" if $p->{country};
        $extra .= "tags: [$p->{tags}]\n" if $p->{tags};
        $extra .= $js;

        open(my $fh, ">:utf8", "$FindBin::Bin/en/_posts/$p->{date}-$p->{url}.html");
        print $fh <<"EOF";
---
url: $p->{url}
title: $p->{title_en}
excerpt: |
$p->{poster_en}
$extra
---
EOF

        my ($year) = ( $p->{date} =~ /^(\d{4})/ );

        open(my $fh1, "<:utf8", "$FindBin::Bin/.mojo/templates/$year/$p->{date}-$p->{url}-en.html.ep");
        while (<$fh1>) {
            print $fh $_;
        }
        close $fh1;
        close $fh;
        
    }
    
    
}


open($fh, ">:utf8", "$FindBin::Bin/_posts/2008-09-16-weather.html");
open(my $fh1, "<:utf8", "$FindBin::Bin/.mojo/2008-09-16-weather.html");
while (<$fh1>) {
    print $fh $_;
}
close $fh1;
close $fh;
