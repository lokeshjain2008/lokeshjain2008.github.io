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


### hosting, cloud editor, terminals
-	[cloud 9](c9.io)
-	[terminal](https://www.terminal.com/)
-	[koding](https://koding.com/)
-	[gitter](https://gitter.im)
-	[ElasticBox](https://elasticbox.com/)
-	[ChefIO](https://www.chef.io/) See video how it works. That is enough for convince me to use it.

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

- **Blogs**
	* http://blog.codeship.com/
  * http://www.sitepoint.com/ruby/

---

### Ruby/Rails gems, Good resouces, Tricks

-[ParallelTest](https://github.com/grosser/parallel_tests)

- Ror, ruby tricks
  *Bundle install is slow for this, There is parallel bundle options
  
  What is the number for the parallel jobs 
	It will be N-1 (N:number of core cpu have)
	how to find number of core machine have.
	`sysctl -n hw.ncpu`
	`lscpu`

  ```sh
	  
	  //Save time using parallel install
		$ bundle config --global --jobs 7 // total cup(8) - 1
		$ time bundle install
	
	```
	If you have problem with the parallel bundle than fallback to the default
	`vim ~/.bundle/config`

	* To serve `precomplied` assets on the develpment

	```sh

	```