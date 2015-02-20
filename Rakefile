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
task :create_post, :name  do |t,args|
p t 
p args

end

task :tests, [:arg1, :arg2] do |t, args|
  puts "First argument: #{ args[:arg1] }"
  puts "Second argument: #{args[:arg2]}"
end

