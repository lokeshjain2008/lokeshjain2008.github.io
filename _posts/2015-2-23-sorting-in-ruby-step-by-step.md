---
layout: post
date: Mon Feb 23 12:13:16 2015
comments: true
title: sorting-in-ruby-step-by-step
tags: [ruby,ruby tips]
---
Sorting is always a great question in each language. Sometime it will become pain if we don't know the power given by the language we are using. Ruby is great in terms of the power and easy given to developer.

Ruby has power full ways of sorting.
Lets have a array that we want to sort.

` ["a", "aaaa", "bb", "bbbb", "bbb", "b", "cc", "c"]`

Do the simple sorting for the given array

```ruby
 array_to_sort = ["a", "aaaa", "bb", "bbbb", "bbb", "b", "cc", "c"]


 p array_to_sort.sort # => ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"]
```
how to do reverse sort now? think. 1st sort than reverse...?

```ruby
p array_to_sort.sort.reverse 
# => ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]
```

We have better solution for the 
use spaceship operator `<=>`

```ruby
p array_to_sort.sort{|one,two| two<=>one} 
# => ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]
```

What if want to sort by length of the elements in word.

```ruby
p array_to_sort.sort{|one,two|one.length <=>two.length} 
# => ["a", "b", "c", "cc", "bb", "bbb", "aaaa", "bbbb"]
```

This is ok till we want only length but we want to sort it by alphabatically too.

```ruby
p array_to_sort.sort_by {|element| [element,element.length]} 
# => ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"] 
```
#### Sorting the `Hash` in ruby. Hashes are great for data representaions.

For example we have one complex hash of people

```ruby
people = {
  :fred => { :name => "Fred", :age => 23 },
  :zade => { :name => "Joan", :age => 18 },
  :jone => { :name => "Pete", :age => 54 }
}


p people.sort # => [[:fred, {:name=>"Fred", :age=>23}], [:jone, {:name=>"Pete", :age=>54}], [:zade, {:name=>"Joan", :age=>18}]]
```

What just happend my `hash` changed into `array` what do i do now? No worries change array to hash again using `to_h`.

```ruby
p people.sort.to_h 
# => {:fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}, :zade=>{:name=>"Joan", :age=>18}}
```

_Is there a better way for more complex sortings? yes, there is look here is saviour `sort_by`_

```ruby
people.sort_by { |k, v| v[:age] }.to_h  
# => {:zade=>{:name=>"Joan", :age=>18}, :fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}}
```




