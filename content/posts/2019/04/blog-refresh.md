---
title: Website refresh
date: 2019-04-09
tags: [nikola, hugo, blog]
---

Hello !

As you may have noticed - this website looks different now ! Why is that ? I've not only changed the visual theme but also a lot of underlying infrastructure.
Let's start with describing the old setup and see where we can improve.
The site previously ran on [Nikola](https://getnikola.com/), was built on [Travis](https://travis-ci.org/cyplo/blog) and then pushed to [Netlify](https://www.netlify.com/), which I later changed to [Github Pages](https://pages.github.com/). While it worked it had some issues of its own;

1. Image galleries were hard to navigate and looked a bit out of place.
2. The site was not rendering the main menu correctly on mobile devices.
3. It was slow to build the site, especially on CI - it took 15 to 30 minutes for the CI run on travis to get the site deployed - not ideal for fast feedback
4. Lack of previews for the work in progress - it was hard for me to set up a preview per branch, updated automatically.

All of the above, mixed with me having a bit of a time off, resulted in getting this site migrated to some new and exciting stack !

It now runs on [Hugo](https://gohugo.io/) and uses Netlify as the deployment target. I fixed all of the problems above and added some more niceties !

1. I'm using [Beautiful Hugo](https://themes.gohugo.io/beautifulhugo/)'s Gallery now - see this [old post](/posts/2016/06/12/dont-throw-away-fix/) for an example
2. This theme also makes the site mobile-friendly out of the box
3. It takes 1-3 minutes for the full site deploy
4. Previews just work :)
5. No need to use [custom Netlify sync script I wrote](/posts/2017/03/netlify-incremental-deployer/) anymore, as Hugo is natively supported on Netlify
6. Netlify supports TLS on multiple domains - you can now use [cyplo.dev](https://blog.cyplo.dev/) as well as [cyplo.net](https://blog.cyplo.net) to reach this site :)

As for how the actual migration was done - it was a bit of work, as you can see in this [PR](https://github.com/cyplo/blog/pull/46). While I could migrate the content mostly automatically, I chose to actually use this opportunity to review all the posts manually !
This allowed me to spot and fix some additional issues, like broken links, editorial mistakes etc.

Overall I think this was worth it - the site is now more modern, the sources are smaller and it is fast to build.
If you're curious about the details - all the sources are [here](https://github.com/cyplo/blog).

Happy blogging !
