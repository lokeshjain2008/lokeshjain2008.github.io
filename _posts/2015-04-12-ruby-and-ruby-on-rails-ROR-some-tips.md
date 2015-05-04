---
layout: post
date: "Sun Apr 12 02:12:05 2015"
comments: true
title: "ruby and ruby on rails ROR some tips"
---
 
 Ruby is greate language and ROR is greatest framework of all time. Both set the standard for the other to follow and learn. I have been using this from long time now and still amazed by it.

 In this post will be adding list of all great plugins and some tips and concepts to keep in mind.

### Greate gems makes you rich.

- `Faye-rails`: this gem helpt to achive pub/sub model in for rails and based on `faye`. 	[link](https://github.com/jamesotron/faye-rails) Here is a [link](http://josephndungu.com/tutorials/gmail-like-chat-application-in-ruby-on-rails) to article that uses `		private_pub` to create message app.
	This can be used for push notifications.[alternates](https://www.google.co.in/search?sourceid=chrome-psyapi2&ion=1&espv=2&ie=UTF-8&q=push%20notification%20in%20rails&oq=push%20notification%20in%20r&aqs=chrome.1.69i57j0l5.4947j0j7) for push

- `RabbitMQ`: Event sourcing on Rails with RabbitMQ. There is link to the greate article using this. [link](http://codetunes.com/2014/event-sourcing-on-rails-with-rabbitmq/)

- `Rubocop`: code analyzer. This gem will analyze your code and and tells you to write good code [link](https://github.com/bbatsov/rubocop)

- `flog`: To read the code complexity of the code you have written. [link](https://github.com/seattlerb/flog)

- `fog`: for the colud maintenance. 

- `Celluloid`: provides a simple and natural way to build fault-tolerant concurrent programs in Ruby. With Celluloid, you can build systems out of concurrent objects just as easily as you build sequential programs out of regular objects.[link](https://github.com/celluloid/celluloid)

- `faraday`: for more read [this] (http://www.intridea.com/blog/2012/3/12/faraday-one-http-client-to-rule-them-all)

- `typhoeus`: for more visit the [link](https://github.com/typhoeus/typhoeus)

- `brakeman`: for sequrity and check for the errors [link](http://railscasts.com/episodes/358-brakeman?view=comments)

- `pundit`: patterns to build a simple, robust and scaleable authorization system.[link](https://github.com/elabs/pundit)

- *Testing*
	- `webmock` , ``
### Some key concepts in ruby and ROR.

- Observers in Rails
	*ActiveRecord::Observers*
  We can delegate the responsiblity of observing changes in model attibutes and responding to those changes, to a seperate Observer class. Model specific event handling is much cleaner this way. This way, we can refrain from polluting the model by adding not un-necessary methods.

  For more visit the [link](http://codebrahma.com/ruby/2014/07/30/observers-in-rails.html)
	This Question on the stackoverflow[link](http://stackoverflow.com/questions/15165260/rails-observer-alternatives-for-4-0) Talks more on `sub/pub` and events. 

 - How to use `concerns` in rails 4?
 	[link](http://stackoverflow.com/questions/14541823/how-to-use-concerns-in-rails-4?rq=1) This Question has great answers to this question