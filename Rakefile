desc "Say hello to the user"
task :task_name do
	p "Hello from the taks file"
end

namespace :learning do

	desc "this will work with namespace"
	task :one  do
		p "inside the loop"
	end

end


desc "Task description"
task :taks_pre do
	p "Hey the task called taks_pre"
end


task :default => :rake_task


desc "Thsi will show the dependency"
task :rake_task => [:task_name,:taks_pre] do
	p "This is based on rake dependency "
end


# send data to the rake bro.
desc "Will create post file in the directory.."
=begin
For the rake paramters it was messing with the ZSH and there was a solution
alias rake='noglob rake'

=end
task :create_post, :name  do |t,args|

 time = Time.new
 file_name =  "_posts/#{time.year}-#{time.month.to_s.rjust(2,'0')}-#{time.day.to_s.rjust(2,'0')}-#{args[:name]}.md"
 touch file_name.gsub!(/\s/,'-')
 content = """
---
layout: post
date: #{time.asctime.to_s}
comments: true
title: #{args[:name].gsub(/[-,_]/,' ').to_s}
---
 """
 File.write(file_name,content)
end

task :tests, [:arg1, :arg2] do |t, args|
  puts "First argument: #{ args[:arg1] }"
  puts "Second argument: #{args[:arg2]}"
end

