---
layout: post
date: Tue Mar 17 10:53:58 2015
comments: true
title: Removing child root nodes in RABL
---

#RABL is greate to create `JSON` output for the api porjects.

Here is the situation to conquer.

```ruby
	collection @groups, :object_root => false

	attributes :id, :name
	child :files do
	  extends "groups/_file"
	end
```
And next, the file partial template.

```ruby
object @file

attributes :id
```

This will produce the output as 

```json
[
   {
      "id":"4f57bf67f85544e620000001",
      "name":"Some Group",
      "files":[
         {
            "file":{
               "id":"4f5aa3fef855441009000007"
            }
         }
      ]
   }
]

```

But we need the output something like this with out parent node for child nodes.

```javascript
[
   {
      "id":"4f57bf67f85544e620000001",
      "name":"Some Group",
      "files":[
         {
            "id":"4f5aa3fef855441009000007"
         }
      ]
   }
]

```
There is solutions

1. change is globally 

```ruby

Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
end

```
2. more control

```ruby
#change this 
child :files do
      extends 'groups/_file'
    end

#Into the code 
node :files do |group|
      group.files.map do |file|
        partial 'groups/_file', object: file, root: false
      end
    end

# or
child :files, :object_root => false do
  extends 'groups/_file'
end

```

Note : if we and to change the behaviour of one element.


```ruby

object @budget_product_promo
attributes :id,
           :name,
           node(:amount){|o|o.amount.to_f},
           :promo_sym,
           :promo_cycle_type,
           :budget_product_id

```



Finally here is some good read for the `eagerload` in rails.

[rails4-preloading](http://blog.arkency.com/2013/12/rails4-preloading/)




