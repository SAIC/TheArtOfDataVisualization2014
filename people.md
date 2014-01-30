---
layout: page
title:  People
---

<ul>
{% for member in site.data.members %}
  <li>
    {{ member.display_name }}
    <ul>
	{% for post in site.posts %}
		{% if post.author == member.username %}
       	<li>
        	{{ post.date | date_to_string }} : <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
    	</li>
		{% endif %}
    {% endfor %}
	</ul>

  </li>
{% endfor %}
</ul>
