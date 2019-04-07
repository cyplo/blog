#!/bin/sh
mysql -u wordpress -p -e "SELECT posts.ID as id, posts.guid AS attachment, posts.post_title AS title FROM  wp_posts as posts WHERE posts.post_type = 'attachment';" wordpress > attachements

