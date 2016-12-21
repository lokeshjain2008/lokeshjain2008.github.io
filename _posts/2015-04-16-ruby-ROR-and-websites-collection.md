---
layout: post
date: "Thu Apr 16 18:01:18 2015"
comments: true
title: "ruby ROR and websites collection"
---
 List of amazing websites for developers. 

amazing tutorial for the new rubist on the ruby...


- [Ruby beginner](http://www.sitepoint.com/ruby-ecosystem-new-rubyists/)
- [Gems collection](https://medium.com/@riklomas/my-favourite-ruby-gems-services-89fb47341c05)

### JavaScript, and other
- The modular backend platform for web developers.[stamplay](https://stamplay.com/)
- JavaScript, Agular blog [scotch](https://scotch.io/)
- Effortless web publishing through Dropbox [harp](http://harp.io)
- Zapier connects the web apps you use to easily move your data and automate tedious tasks [Zapier](https://zapier.com/)
- For the data storing like firebse [parse)](https://parse.com/)

### hosting, cloud editor, terminals
- [cloud 9](c9.io)
- [terminal](https://www.terminal.com/)
- [hyper terminal for all the platform](https://hyper.is/)
- [Package manager for windows Choco](https://chocolatey.org/)
- [Static website and more Now&Next](https://zeit.co/now#)
- [Static website hosting surge.sh](https://surge.sh/)
- [koding](https://koding.com/)
- [intercityup](https://intercityup.com/) Rails hosting.
- [cloud66](http://www.cloud66.com/) Script free Ops for Developers(Hosting and Server)
- [lenode](https://www.linode.com/) Cloud Hosting for You. High performance SSD Linux servers for all of your infrastructure needs.
-	[gitter](https://gitter.im) Chat, for GitHub.
-	[ElasticBox](https://elasticbox.com/)
-	[ChefIO](https://www.chef.io/) See video how it works. That is enough for convince me to use it.
- [Electron](http://electron.atom.io/) To create destop application using Web-technologies(js/html/css).
- [StrongLoop](https://strongloop.com/) Compose APIs, Build, Deploy and Monitor Node. Need to check this out.
- [paw](https://luckymarmot.com/paw) The unltimate REST api client for Mac.
---

### Good websites with great content and `blogs`.
- [Ruby 2.2 new methods](http://www.sitepoint.com/new-methods-ruby-2-2/)
- [Image processing in ruy](http://www.sitepoint.com/image-processing-rails/)
- [rake tips](https://github.com/ruby/rake)
- [parallelism in ruby](http://www.toptal.com/ruby/ruby-concurrency-and-parallelism-a-practical-primer)
	**Testing (spec / cucumber / )**
- [mocking/stubing/double](http://blog.codeship.com/rspec-stub-and-mock/)
- [Fast testing](http://blog.codeship.com/faster-rails-tests/)-http://www.sitepoint.com/ruby/
- [Rails preloading](http://blog.arkency.com/2013/12/rails4-preloading/)
- [Rails+grep+ember](https://devmynd.com/blog/2014-7-rails-ember-js-with-the-ember-cli-redux-part-1-the-api-and-cms-with-ruby-on-rails)

- **Blogs**
  * [CodeShip](http://blog.codeship.com/)
  * [Sitepoint](http://www.sitepoint.com/ruby/)
  * [CodeSchool](https://www.codeschool.com/blog/archive/)
  * [Arkency](http://blog.arkency.com/)

---

### Ruby/Rails gems, Good resouces, Tricks

- [ParallelTest](https://github.com/grosser/parallel_tests)
- [Sucker_puch](https://github.com/brandonhilkert/sucker_punch) Sucker Punch is a Ruby asynchronous processing library using Celluloid, heavily influenced by Sidekiq and girl_friday.
- []()

- Ror, ruby tricks
  * Bundle install is slow for this, There is parallel bundle options
	  What is the number for the parallel jobs 
		It will be N-1 (N:number of core cpu have)
		how to find number of core machine have.
		`sysctl -n hw.ncpu`, `lscpu`.

		```
			  
		  //Save time using parallel install
			$ bundle config --global --jobs 7 // total cup(8) - 1
			$ time bundle install

		```

		If you have problem with the parallel bundle than fallback to the default
		`vim ~/.bundle/config`

	* To serve `precomplied` assets on the develpment

		```sh
			
			RAILS_EVN=development rake assets:precomplie

		```