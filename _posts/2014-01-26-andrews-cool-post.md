---
layout: post
title:  "Cool Post by Andrew Monks!"
date:   2014-01-28 00:00:00
categories: post
author: amonks
---

# Hi!

I'm [Andrew Monks](http://monks.co/). This is a new post on the Art Of Data Visualization class website! I wrote it (like a boss).

## Here are some other posts.

{% for post in site.posts %}

-	[{{ post.title}}]({{ post.url }})

{% endfor %}

## That's all. Thanks, everyone!