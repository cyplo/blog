.. title: Adding graphs to posts in Nikola
.. slug: adding-graphs-to-posts-in-nikola
.. date: 2017-07-15 20:13:50 UTC
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text

I really like to teach, try to explain things in a simple manner. There is often no better way of making an explanation than visualizing it.
The problem is that I really can't draw, especially on a computer.
Wouldn't it be awesome if I could make a computer draw for me ?
I found out that unsurprisingly there is a software for that already. The one I like is called mermaid

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

