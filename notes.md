---
layout: page
title:  Notes
---

<ul class="list-unstyled">
    {% for post in site.categories.notes %}	
    {% assign author = site.authors[post.author] %}
    <!-- <img class="img-circle" src="http://www.gravatar.com/avatar/{{ author.gravatar }}?s=30&d=identicon"/> -->
    <li>
        {{ post.date | date_to_string }} :
        <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    </li>
    {% endfor %}
</ul>
