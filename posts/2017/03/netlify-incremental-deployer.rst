.. title: Upload your site to Netlify using their incremental deployment API
.. slug: netlify-incremental-deployer
.. date: 2017-03-20 19:25:25 UTC
.. tags: blog, netlify, python, deployment
.. category: infrastructure
.. type: text

I've recently switched to a setup where I do all my builds for this blog on `Travis <https://travis-ci.org/cyplo/blog>`__. While doing so I needed to migrate away from using Netlify's internal build infrastructure. This resulted in a quick `python script <https://github.com/cyplo/netlify_deployer>`__ that allows you to upload arbitrary directory tree to Netlify and does so using their `incremental deployment API <https://www.netlify.com/docs/api/#deploying-to-netlify>`__. All that means that while this site is quite big in size the deployments go rather quickly ! There are some `known issues <https://github.com/cyplo/netlify_deployer/issues>`__ but apart from them the script should just work for any custom Netlify deployment you would like to have. I use it on this very site, to have a preview of any PR before merging it as well as for deploying the main site after the PR is merged. I hope you will find it useful and please do not hesitate if you want to post an issue or a PR !