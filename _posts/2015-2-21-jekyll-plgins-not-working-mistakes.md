---
layout: post
comments: true
title: "How to add jekyll plugin to my blog"
tags: [mistakes,jekyll,jekyll-plugin]
---
'Jekyll' is awesome for the developers who are familiar with `github`. This becomes easy to write blogs and share common mistakes and solutions.


###Mistakes
---
According to the jekyll-documentations we can include 'plugins' as 
{% highlight yaml %}
	#_confing.yaml 
	gem: [plugin-name]

{% endhighlight %}

Add this gem to Gemfile and install it.
`gem install plugin-name`


_Mistakes that i commited in the process_
1. mistaken the gem with plugin. 

```yaml
#_confing.yaml
plugins: [plugin-name] 
```
2. put plugins in the `_plugins` directory.
3. No plugin was workign as expected.

###Solutions
---
Either follow the given step above but that is not suitable as almost every `jekyll-plugin` is 
a module.
the correct way is to 
1. create `_plugins' directory.
	`mkdir _plugins`
2. in `_confing.yaml` remove all the keys related to plugins or gem.
3. Just add the modules/files to the `_plugins` folder.

This is the way to work with jekyll-plugins.



