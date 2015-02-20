=begin
Object serialization in ruby and 
1. marshal
2. yaml
3. json

=end

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

p Marshal.load(data) # => #<Test:0x007fb1910938d8 @name="lokesh", @age=25>

p a # => #<Test:0x007fb191093dd8 @name="lokesh", @age=25>


# >> #<Test:0x007faf6b0ed2c0 @name="lokesh", @age=25>
# >> "\x04\bo:\tTest\a:\n@nameI\"\vlokesh\x06:\x06EF:\t@agei\x1E"
# >> #<Test:0x007fb1910938d8 @name="lokesh", @age=25>
# >> #<Test:0x007fb191093dd8 @name="lokesh", @age=25>