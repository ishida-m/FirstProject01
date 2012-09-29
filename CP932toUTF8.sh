#!/bin/bash

## for file in `find ./script -name "*.R" -o -name "*.csv"`;

for file in `find ./script -type f"`;
do
    echo $file
    iconv -f CP932 -t UTF-8 $file > tmpfile
    mv tmpfile $file
done
exit
