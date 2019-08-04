#!/bin/bash

infile=$1 # input pdf

main_suffix=${2:}

app_suffix=${3:-_appendix}


$page = pdftk "$inflie" dump_data | grep -A 2 -i 'appendix\|supplement' | grep '^BookmarkPageNumber'| grep -Eo '[0-9]{1,4}' 


path=$(dirname $infile)

main_name=$(basename $infile)

main_name=${main_name%%.*}


pdftk $path cat 1-$($page-1) output $path/$main_name$main_suffix.pdf

pdftk $path cat $page-end output $path/$main_name$app_suffix.pdf
