#!/bin/bash

FILES=files
POSTS=posts
ATTACHEMENTS_LIST=helpers/attachements

gallery_pattern="(?<=\[gallery ids\=\")(.*)(?=\")"
grep_search_options="-iP"
grep_extract_options="$grep_search_options -o"
files_to_change=`find $POSTS -iname "*.wp" -o -iname "*.md" | xargs grep $grep_search_options "$gallery_pattern" | cut -f 1 -d:`

for file in $files_to_change
do
    echo
    echo "changing" $file
    image_ids_text=`grep $grep_extract_options "$gallery_pattern" $file`
    image_ids=`echo $image_ids_text | sed 's/\,/\n/g'`
    echo "get image IDs $image_ids"
    image_tags=""
    for image_id in $image_ids 
    do
        image_info=`grep -i $image_id $ATTACHEMENTS_LIST`
        if [ -z "$image_info" ] 
        then
            echo "error finding image for id $image_id, skipping"
            continue
        fi

        image_filename=`echo $image_info | cut -f 3 -d' '`
        image_filepath=`find "$FILES" -iname "$image_filename.jpg"`
        full_image_url=`echo "$image_filepath" | sed "s/$FILES//g"`
        thumb_url=`echo "$full_image_url" | sed "s/$image_filename/$image_filename-150x150/g"`
        image_tag="<a href='$full_image_url'><img src='$thumb_url' /></a>"
        image_tags="$image_tags\n$image_tag" 
    done
    echo -e "$image_tags" >> "$file"
done

