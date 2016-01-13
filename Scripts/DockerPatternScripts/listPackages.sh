#!/bin/bash

grep --no-filename -r "^\s*package " | while read -r packLine; do
perl <<__HERE__
my \$packLine="$packLine";
print "$packLine" =~ /^\s*package (\w+)/; 
print "\n";
__HERE__
done | sort | uniq
