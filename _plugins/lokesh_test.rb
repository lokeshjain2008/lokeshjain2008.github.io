class MyNewCommand < Jekyll::Command
  class << self
  	def say_hi
  		p "Hi lokesh kumar jain"
  	end

  end
end