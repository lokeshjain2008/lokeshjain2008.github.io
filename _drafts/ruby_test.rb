require 'rspec'

double('book',name:"lokesh") # => 

class Test
 def initialize(name,age)
 	@name = name
 	@age = age
 end
end
a =  Test.new("lokesh",25)

data = Marshal.dump(a) # => 

Marshal.load(data) # => 


########### SORTING============

#  Do the simple sorting for the given array

 array_to_sort = ["a", "aaaa", "bb", "bbbb", "bbb", "b", "cc", "c"]


array_to_sort.sort # => 

# how to do reverse sort now? think. 1st sort than reverse...?

array_to_sort.sort.reverse # => 

# We have better solution for the 
# use spaceship operator `<=>`

array_to_sort.sort{|one,two| two<=>one} # => 

# What if want to sort by length of the elements in word.

array_to_sort.sort{|one,two|one.length <=>two.length} # => 

# This is ok till we want only length but we want to sort it by alphabatically too
array_to_sort.sort_by {|element| [element,element.length]} # => 



people = {
  :fred => { :name => "Fred", :age => 23 },
  :zade => { :name => "Joan", :age => 18 },
  :jone => { :name => "Pete", :age => 54 }
}


people.sort # => 

# What just happend my `hash` changed into `array` what do i do now?

people.sort.to_h # => 

# Is there a better way for more complex sortings? yes, there is look here is saviour `sort_by

people.sort_by { |k, v| v[:age] }.to_h  # => 


## Delegations in ruby 


# EQUALITY IN RUBY

# 1. =~ Takes regualr expression for the checking in the value
"this the test string" =~ /string/ # => 


"this the test string" =~ /(\s\w+)/ # => 
#Note above will not capture the vlaue

# 2. eql? and ==

"lokesh" == "Lokesh" # => 

a = [1,2,3]
b = a
# will pass all the checking
a == b # => 
a.eql? b # => 
a.equal? b # => 

a = b.dup
# Now. equal? will fail
a ==b # => 
a.eql? b # => 
a.equal?b # => 

a,b = 1,1.0
# Strict check using eql?
a==b # => 
a.eql?(b) # => 


# ~> 	from -:1:in `<main>'
# ~> -:3:in `<main>': undefined method `double' for main:Object (NoMethodError)