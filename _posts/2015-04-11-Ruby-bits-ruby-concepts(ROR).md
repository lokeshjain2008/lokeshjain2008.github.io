---
layout: post
date: "Sat Apr 11 00:02:07 2015"
comments: true
title: "Ruby-bits-ruby-concepts"
---
Create sample Exception handling for the ruby code.

Example 1

```ruby

class Test 
	def hello # !> previous definition of hello was here
		begin 
			1/0
		rescue =>e
			p "#{e.message}, Error occured."
		end

	end

end

Test.new.hello # => "divided by 0, Error occured."

```


If we want to raise by our self based on the user values with messge

```ruby
class Test
	def hello # !> method redefined; discarding old hello
		begin 
			raise 'some error'
		rescue =>e
			p "#{e.message}, Error occured."
		end
	end
end
Test.new.hello # => "some error, Error occured."

```

We can pass some messge to raise error case. But this will not work if the strings.


```ruby
class Test 
	def hey
		begin
			raise 'my Error', 'This is raised by me'
		rescue =>e
			p "#{e.message} !"
		end
	end
end

Test.new.hey # => "exception class/object expected !"

```

We should create new a custom exception class handling for this.

```ruby

class CustomException < StandardError

	def initialize object
		object.to_s
	end

	def to_s
		"This is to_s method"
	end

end

class Test
	def custom
		begin
			raise CustomException.new(self) , "This is messge is here"
		rescue =>e
			p "#{e.message} , Error!!"
		else
		ensure
		end
	end
end

Test.new.custom # => "This is to_s method , Error!!"
```

For Explanation see this ** [link](http://stackoverflow.com/questions/16106645/ruby-custom-error-classes-inheritance-of-the-message-attribute) **
