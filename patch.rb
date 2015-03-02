#This file create patch using git diff 
time =  Time.new
#create temp file to read and save data in the file
temp_file = "temp_#{time.to_i}.txt"
`touch #{temp_file}`
`git status | grep modified >> #{temp_file}`
files_raw = File.readlines(temp_file)

files_raw.each do |file_raw|  
	file = file_raw.gsub(/[\n\t]/,'').split(":").last.strip
	`rsync -R #{file} patch-folder-#{time.to_i}/`
end