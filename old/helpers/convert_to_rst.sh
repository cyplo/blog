#!/bin/bash
for file in $(find -iname "*.md"); do
    base=`basename $file`
    base=${base%.*}
    dir=`dirname $file`
    rst="$dir/$base.rst"
    pandoc --from html --to rst "$file" -o "$rst" 
    rm -fv "$file"
done
