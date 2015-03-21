#Guide to ruby testing 
=begin
Learning the testing first is a real ruby way.
Here we will learn some basic things to test our ruby.
=end

# require 'rspec'
# require 'respc-core'

RSpec.describe "A test double" do
  it "returns canned responses from the methods named in the provided hash" do
    dbl = double("Some Collaborator", :foo => 3, :bar => 4)
    expect(dbl.foo).to eq(3)
    expect(dbl.bar).to eq(4)
  end
end


# require_relative 'spec/spec_helper'


class StringChanger


	def reverse_and_save(string)
		string.reverse.tap do |reverse|
		# next code to solve the specs

			File.write('example_file',reverse)		
		end
	end
end


describe StringChanger do
  it 'reverses strings' do
    string_changer = StringChanger.new

    reversed_string = string_changer.reverse_and_save('example string')

    expect(reversed_string).to eq 'gnirts elpmaxe'
  end
end

=begin
output will for this test are as...
 1) StringChanger reverses strings
     Failure/Error: reversed_string = string_changer.reverse_and_save('example string')
     NoMethodError:
       undefined method `reverse_and_save' for #<StringChanger:0x007f8df79d6958>
     # ./ruby_tests_spec.rb:16:in `block (2 levels) in <top (required)>'

Finished in 0.00049 seconds (files took 0.12771 seconds to load)
1 example, 1 failure



=== All it says that there is no method named `reverse_and_save`
Now go to ther other spec that tries to save the content to the file..
=end

describe 'this will save the file' do 
	it 'saves string to the file system' do
	  string_changer = StringChanger.new
	  File.stub(:write)

	  string_changer.reverse_and_save('example string')

	  expect(File).
	    to have_received(:write).
	    with('example_file', 'gnirts elpmaxe').
	    once
	end

end

# ~> 	from -:7:in `<main>'