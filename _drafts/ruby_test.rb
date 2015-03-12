=begin
Object serialization in ruby and 
1. marshal
2. yaml
3. json

=end
require 'yaml'

class Test
	attr_accessor :name, :age

	def initialize(name,age)
		@name = name
		@age = age
	end

	def lokesh
		
	end


end


a =  Test.new("lokesh",25)

data = Marshal.dump(a)

p data # => "\x04\bo:\tTest\a:\n@nameI\"\vlokesh\x06:\x06EF:\t@agei\x1E"

p Marshal.load(data) # => #<Test:0x007fac591c2d18 @name="lokesh", @age=25>

p a # => #<Test:0x007fac591c3678 @name="lokesh", @age=25>

## yaml formatting

data =  File.open("temp_yaml_dump.txt", "w") { |file| YAML.dump(a, file) }

p File.open("temp_yaml_dump.txt") { |file| YAML.load(file) } # => #<Test:0x007fac591b9290 @name="lokesh", @age=25>

########### SORTING============

#  Do the simple sorting for the given array

 array_to_sort = ["a", "aaaa", "bb", "bbbb", "bbb", "b", "cc", "c"]


p array_to_sort.sort # => ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"]

# how to do reverse sort now? think. 1st sort than reverse...?

p array_to_sort.sort.reverse # => ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]

# We have better solution for the 
# use spaceship operator `<=>`

p array_to_sort.sort{|one,two| two<=>one} # => ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]

# What if want to sort by length of the elements in word.

p array_to_sort.sort{|one,two|one.length <=>two.length} # => ["a", "b", "c", "cc", "bb", "bbb", "aaaa", "bbbb"]

# This is ok till we want only length but we want to sort it by alphabatically too
p array_to_sort.sort_by {|element| [element,element.length]} # => ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"]



people = {
  :fred => { :name => "Fred", :age => 23 },
  :zade => { :name => "Joan", :age => 18 },
  :jone => { :name => "Pete", :age => 54 }
}


p people.sort # => [[:fred, {:name=>"Fred", :age=>23}], [:jone, {:name=>"Pete", :age=>54}], [:zade, {:name=>"Joan", :age=>18}]]

# What just happend my `hash` changed into `array` what do i do now?

p people.sort.to_h # => {:fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}, :zade=>{:name=>"Joan", :age=>18}}

# Is there a better way for more complex sortings? yes, there is look here is saviour `sort_by

people.sort_by { |k, v| v[:age] }.to_h  # => {:zade=>{:name=>"Joan", :age=>18}, :fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}}


## Delegations in ruby 


# EQUALITY IN RUBY

# 1. =~ Takes regualr expression for the checking in the value
"this the test string" =~ /string/ # => 14


"this the test string" =~ /(\s\w+)/ # => 4
#Note above will not capture the vlaue

# 2. eql? and ==

"lokesh" == "Lokesh" # => false

a = [1,2,3]
b = a
# will pass all the checking
a == b # => true
a.eql? b # => true
a.equal? b # => true

a = b.dup
# Now. equal? will fail
a ==b # => true
a.eql? b # => true
a.equal?b # => false

a,b = 1,1.0
# Strict check using eql?
a==b # => true
a.eql?(b) # => false

# if you are seeing SSL error
 OpenSSL::SSL::VERIFY_NONE.






# >> {:fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}, :zade=>{:name=>"Joan", :age=>18}}
# >> "\x04\bo:\tTest\a:\n@nameI\"\vlokesh\x06:\x06EF:\t@agei\x1E"
# >> #<Test:0x007fac591c2d18 @name="lokesh", @age=25>
# >> #<Test:0x007fac591c3678 @name="lokesh", @age=25>
# >> #<Test:0x007fac591b9290 @name="lokesh", @age=25>
# >> ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"]
# >> ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]
# >> ["cc", "c", "bbbb", "bbb", "bb", "b", "aaaa", "a"]
# >> ["a", "b", "c", "cc", "bb", "bbb", "aaaa", "bbbb"]
# >> ["a", "aaaa", "b", "bb", "bbb", "bbbb", "c", "cc"]
# >> [[:fred, {:name=>"Fred", :age=>23}], [:jone, {:name=>"Pete", :age=>54}], [:zade, {:name=>"Joan", :age=>18}]]
# >> {:fred=>{:name=>"Fred", :age=>23}, :jone=>{:name=>"Pete", :age=>54}, :zade=>{:name=>"Joan", :age=>18}}