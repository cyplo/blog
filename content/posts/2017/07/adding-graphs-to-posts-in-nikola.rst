.. title: Adding graphs to posts in Nikola
.. slug: adding-graphs-to-posts-in-nikola
.. date: 2017-07-15 20:13:50 UTC
.. tags: nikola, blog, mermaid, rst, graph
.. category: blog
.. type: text

I really like to teach, try to explain things in a simple manner. There is often no better way of making an explanation than visualizing it.
The problem is that I really can't draw, especially on a computer.
Wouldn't it be awesome if I could make the computer draw for me ?
I found out that, unsurprisingly, there is a software for that already. The one I like is called mermaid - it renders a simple text description of a graph or diagram into an html representation. Can look something like this.

.. raw:: html
 
	 <div class="mermaid">
	 graph TB
			 subgraph one
			 a1-->a2
			 end
			 subgraph two
			 b1-->b2
			 end
			 subgraph three
			 c1-->c2
			 end
			 c1-->a2
	 </div>

This blog is rendered by Nikola hence I would like to show you how I've added mermaid support to my Nikola installation.
I use ``USE_BUNDLES = False`` in ``conf.py`` as for it gives me more control and is more HTTP/2 friendly.
With that disabled I can include mermaid's style and js files like so (also in ``conf.py``):

.. code-block:: python

	EXTRA_HEAD_DATA = """
	<link rel="stylesheet" type="text/css" href="/assets/css/fontawesome.css">
	<link rel="stylesheet" type="text/css" href="/assets/css/titillium.css">
	<link rel="stylesheet" type="text/css" href="/assets/css/mermaid.forest.css">
	"""

	BODY_END = """
	<script src="/assets/js/mermaid.js"></script>
	<script>mermaid.initialize({startOnLoad:true, cloneCssStyles: false});</script>
	"""

Where do all these files come from though ? In my case, I have a custom theme, based on ``zen`` called ``zen-cyplo``. The assets in the sources are located under ``themes/zen-cyplo/assets/``.
Oh, and ``cloneCssStyles: false`` is there as the default of ``true`` made the different css styles on my blog clash.
Finally, to use mermaid in the post do (for reStructured Text):

.. code-block:: restructuredtext

	.. raw:: html
	
		<div class="mermaid">
		graph TB
				subgraph one
				a1-->a2
				end
				subgraph two
				b1-->b2
				end
				subgraph three
				c1-->c2
				end
				c1-->a2
		</div>

You can click on ``source`` button located below the title of this post to see it in action. If you are interested in the build process and how all these come together - the complete sources for this blog are hosted under https://github.com/cyplo/blog