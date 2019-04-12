---
title: Wordpress and nonstandard ports and protocols
date: 2014-01-01 11:32:36
tags: [tls, wordpress]
category: software
---

I needed to set up a Wordpress installation where https is on
nonstandard port and the admin interface lives in that land, while the
site itself is using plain http.

In `wp-config.php`:

```php
if (!empty($_SERVER['HTTPS'])) {
    define('WP_SITEURL', 'https://example.com:12345');
    define('WP_HOME', 'https://example.com:12345');
}
else {
    define('WP_SITEURL', 'http://example.com');
    define('WP_HOME', 'http://example.com');
}
```

This allows the installation to properly see resources like
images and css if accessed via nonstandard port. So if you don't see
image previews in the admin panel, your styles look weird, or you just
don't see new posts' previewes - this might be it.
