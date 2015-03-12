=begin

function info(){}

info.send =  function(){
  
}


=end


#Guide to ruby testing 
=begin
Learning the testing first is a real ruby way.
Here we will learn some basic things to test our ruby.
=end

# 1. Testing the validations and callbacks in the ActiveRecord 
# 1.1 By the old way to do the test the callbacks are .
# before_save :check_values
it 'should test before_save callbacks' do 
  is_expected.to receive(:check_values)
  subject.save
end

# Or use 'shoulda-matcher for this'
# `shoulda-callback-matchers` gem will do the heavy lifting for us
it{is_expected.to callback(:check_values).before(:save)}

# require 'rspec'
# require 'respc-core'

class User < ActiveRecord::Base
has_many :projects

def full_name 
  "#{first_name} #{last_name}"
end

end

class Project 
  belongs_to :Project

end

describe "user has project " do 
it "should be named after user's name"do 
  first_name,last_name = 2.times.map{random_name}

  user = User.new first_name: first_name,last_name: last_name 
  project = Project.new
  project.user  = user
  project.name.should eq("#{first_name} #{last_name}'s project")
end

# After the stubbing the code
it "should be named after user's name" do 
  # first_name,last_name = 2.times.map{random_name}
  full_name =  random_name
  # Stubbing
  user = User.new
  #Stub the user's full_name property with our full_name
  user.stub full_name: full_name
  # user = User.new first_name: first_name,last_name: last_name 
  project = Project.new
  project.user  = user
  project.name.should eq("#{full_name}'s project")
end

#Stubing ---> Mocking Will mock the full object
it "should be named after user's name" do
  # mock is an object we can use in behalf of other object and will have property we assign to it.
  user = mock_model User, full_name: full_name
  project = Project.new
  project.user  = user
  project.user.should eq("#{full_name}'s project")
end
# Double for the mocking --- the final step1 
it "should be named after user's name" do
  # mock is an object we can use in behalf of other object and will have property we assign to it.
  user  = double(full_name: full_name)
  project = Project.new
  project.user  = user # this will fails as the Active record associations so stub the user property of the project
  project.stub user: user # this will work.ÔˆÔˆŒŒÅ
  project.user.should eq("#{full_name}'s project")
end

# Double for the mocking --- the final step2 and finish
it "should be named after user's name" do
  # mock is an object we can use in behalf of other object and will have property we assign to it.

  project = Project.new
  project.user  = user # this will fails as the Active record associations so stub the user property of the project
  project.stub user: double( full_name: full_name)
  project.user.should eq("#{full_name}'s project")
end

def random_name
  ('a'..'v').to_a.sample(4).join
end

end




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

# Known things for the rspec
# Behaviour of the data based on the trasactional_fixtures = true
# data in the database will be rolledback for every example and will be refreshed.
# difference in before(:each) {} == before {} and before(:all) for the database changes
# need before(:after) to clear database if before(:all) is used.
# Diffrence betweeen eql? `equal?` and `==` in ruby 
#
=begin
RSpec.configure do |c|
  c.use_transactional_examples = true
end

in Rspec no need to specify the  type: controller/model / :request /:feature
if 

# spec/rails_helper.rb
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end

else need to specify


in the controller view are stubbded by default 
render_views to render them and then 
reposne.body to  match \first item\



=end




/usr/local/rvm/gems/ruby-2.1.5@proposal_tool/gems/webmock-1.20.4/lib/webmock/http_lib_adapters/net_http.rb:114:in 
`request': Real HTTP connections are disabled. 
Unregistered request: GET https://qweb700.dyn.wh.reachlocal.com/_ajax/run_report.php?access_key=51596f8559aa15f06bf9dcd9ab7317ab&link_name=Get%20Population%20By%20Country&platform=USA&user_id=43 
with headers {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'} (WebMock::NetConnectNotAllowedError)

You can stub this request with the following snippet:

stub_request(:get, "https://qweb700.dyn.wh.reachlocal.com/_ajax/run_report.php?access_key=51596f8559aa15f06bf9dcd9ab7317ab&link_name=Get%20Population%20By%20Country&platform=USA&user_id=43").
  with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "", :headers => {})

[testing and mocking](https://robots.thoughtbot.com/how-to-stub-external-services-in-tests)
[Best article for testing](https://semaphoreci.com/blog/2013/08/14/setting-up-bdd-stack-on-a-new-rails-4-application.html)
