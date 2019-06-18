---
layout: main
---

<main class="home" id="post" role="main" itemprop="mainContentOfPage" itemscope="itemscope" itemtype="http://schema.org/Blog">
    <div id="grid" class="row flex-grid">
	{% for event in page.events %}
		<article class="box-item" itemscope="itemscope" itemtype="http://schema.org/BlogPosting" itemprop="blogPost">
            <span class="category">
                <a href="{{ site.url }}{{ site.baseurl }}/category/{{ post.category }}">
                    <span title="{{ event.channel_title }}">{{ event.category }}</span>
                </a>
            </span>
            {% include new-post-tag.html date=event.date %}
            <div class="box-body">
                {% if event.image %}
                    {% if event.image.empty? %}
                    {% else %}
                        <div class="cover">
                            <a href="{{ event.link }}">
                                <img src="/assets/img/placeholder.png" data-url="{{ event.image }}" class="preload">
                            </a>
                        </div>
                    {% endif %}
                {% elsif event.images %}
                    {% include new-post-tag.html date=event.date %}
                    <div class="cover collage">    
                        {% for image in event.images %}
                            <a href="{{ event.link }}">
                                <img src="{{image}}" data-url="{{ image }}" class="preload">
                            </a>
                        {% endfor %}
                    </div>
                {% endif %}
                <!-- {%if isnewpost %}new-post{% endif %} -->
                <div class="box-info ">
	                <meta itemprop="datePublished" content="{{ event.date | date_to_xmlschema }}">
	                <time itemprop="datePublished" datetime="{{ event.date | date_to_xmlschema }}" class="date">
	                    {% include date.html date=event.date %}
	                </time>
                    <a class="post-link" href="{{ event.link }}">
                        <h2 class="post-title" itemprop="name">
                            {{ event.title }}
                        </h2>
                    </a>
                    <a class="post-link" href="{{ event.link }}">
                        <!--<p class="description">By {{ event.authors }}</p>-->
                        {% if event.html_description %}
                        	<p class="description">{{ event.description }}</p>
                        {% else %}	
                        	<p class="description">{{ event.description | strip_html }}</p>
                        {% endif %}
                    </a>
                    <div class="tags">
                        {% for tag in event.tags %}
                            <a href="{{ site.baseurl}}/tags/#{{tag | slugify }}">{{ tag }}</a>
                        {% endfor %}
                    </div>
                </div>
            </div>
        </article>
	{% endfor %}
    </div>
</main>