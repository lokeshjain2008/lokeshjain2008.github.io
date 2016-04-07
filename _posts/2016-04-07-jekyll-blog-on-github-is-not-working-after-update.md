---
layout: post
date: "Thu Apr  7 17:30:12 2016"
comments: true
title: "jekyll blog on github is not working after update"
tags:
	- ruby
	- jekyll
	- jekyll not working
---

Jekyll blog on github is not after upate.

I have been using `jekyll` to write blog for some years. This blog is using the same and hosted on github.
My setting is to keep `gems` updated as per github.

gemfile

```ruby

source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
gem 'jekyll-sitemap'
gem 'jekyll-feed'

```

So, every time i rub `bundle` (bundle install) it gets the latest version that github is using.

But in the recent `jekyll` version `3`. there are some changes that broke the `build` process on the github.

There is a nice thing about that you will get `email` about the error that broke the build process.

Here is the reason.

Recently they have decided to support only one makrdown scheme.

Note: these setting are done in the `_config.yml` file.

change

```yml

 # _config.yml
 # Build settings
 markdown: redcarpet


```

to


```yml

# Build settings
 kramdown:
   # Use GitHub flavored markdown, including triple backtick fenced code blocks
   input: GFM
   # Jekyll 3 and GitHub Pages now only support rouge for syntax highlighting
   syntax_highlighter: rouge
   syntax_highlighter_opts:
     # Use existing pygments syntax highlighting css
     css_class: 'highlight'

# will publish your post in that instant (keeps me bothering whay my recent post are not showing.)
 future: true
```

Hope this help someone looking for help on the jekyll issue.
