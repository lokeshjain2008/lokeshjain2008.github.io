---
layout: post
comments: true
title: ruby resources
---
List of great gem 
https://medium.com/@riklomas/my-favourite-ruby-gems-services-89fb47341c05

amazing tutorial for the new rubist on the ruby...
http://www.sitepoint.com/ruby-ecosystem-new-rubyists/

[Rails template](http://stackoverflow.com/questions/11390512/new-to-rails-which-one-do-you-suggest-and-why-erb-haml-or-slim)

### save time using parallel bundler install 
```sh
$ bundle config --global --jobs 8
$ time bundle install
```
What is the number for the parallel jobs 
It will be N-1 (N:number of core cpu have)
how to find number of core machine have.
`sysctl -n hw.ncpu`

If you have problem with the parallel bundle than fallback to the default
`vim ~/.bundle/config`
[Ruby 2.2 new methods](http://www.sitepoint.com/new-methods-ruby-2-2/)
[Image processing in ruy](http://www.sitepoint.com/image-processing-rails/)
[rake tips](https://github.com/ruby/rake)