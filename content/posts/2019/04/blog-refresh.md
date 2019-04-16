---
title: Website refresh
date: 2019-04-09
tags: [nikola, hugo, blog]
draft: true
---

Hello !

As you may have noticed - this website looks differently now ! Why is that ? I've not only change the visual theme but also a lot of underlying infrastructure.
Let's start with the old setup it was Nikola, built on Travis and then pushed to Netlify, which I later changed to Github Pages. While it worked in had some issues of its own;

1. Image galleries were hard to navigate and looked a bit out of place.
2. The site was not rendering the menu correctly on mobile devices.
3. It was slow to build the site, especially on CI - it took 15 to 30 minutes for the CI run on travis to get the site deployed - not ideal for fast feedback
4. Lack of previews for the work in progress - it was hard for me to set up a preview per branch, updated automatically.

All of the above, mixed with me having a bit of a time off resulted in getting this site migrated to some new exciting tech !

It now runs on Hugo and uses Netlify as the deployment target. I fixed all of the problems above and added some more niceties !

1. I'm using Hugo Beutiful's Gallery now - see example
2. Again, the theme was mobile-friendly form the start
3. It takes 1-3 minutes for the full site deploy
4. Previes just work :)
5. No need to use custom Netlify sync script anymore as Hugo is natively supported
6. Netlify supports TLS on multiple domains - please welcome cyplo.dev :)

- back to netlify, but without custom sync script - mention link to script - deploys are much faster now
- new domain
- new design
- made sure links work
- made sure tags are consistent
- removed thumbnails - generated on the fly now
- wording - guys -> folks
- easy to compose custom templates with the theme ones - see how 'series' is done in the repo
- smaller repo overall - count number of files ?
- reduce negativity
