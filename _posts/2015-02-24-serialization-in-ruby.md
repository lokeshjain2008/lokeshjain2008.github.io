---
layout: post
date: Tue Feb 24 00:22:37 2015
comments: true
title: serialization-in-ruby
---
 We need serialization in ruby for the data data sharing and object sharing in the program.
 There are three methods for the serialization in ruby. 
 1. `Yaml`
 2. `Marshaling`
 3. 'Json'

 <!-- --- -->

 Here is ruby code 

 ```ruby
 {"name"=>"David",
 "height"=>124,
 "age"=>28,
 "children"=>{"John"=>{"age"=>1, "height"=>10},
             "Adam"=>{"age"=>2, "height"=>20},
             "Robert"=>{"age"=>3, "height"=>30}},
 "traits"=>["smart", "nice", "caring"]}
```

All three methods have `load` and `dump` method.

1. Marshal.dump 
2. Marshal.load
- YAML::dump()
- YAML::load()
- JSON:: dump
- JSON::load

Note: `json` doesn't doesn't work for the object serialization.

```ruby
class Test
	attr_accessor :name,:age
	def initialize name, age
		@name = name
		@age  = age
	end
end

test_object = Test.new "Hello world",9998989
```
~ JSON::dump(test_object)  will fail ~