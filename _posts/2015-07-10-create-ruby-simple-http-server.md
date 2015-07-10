---
layout: post
date: "Fri Jul 10 23:54:30 2015"
comments: true
title: "create ruby simple http server"
---

A Simple Web Server in Ruby
Posted on November 11, 2011
Few days back I had a job interview with a San Francisco based start up. The interviewer called me over Skype and asked me to write a simple web server in Ruby. The milestones were:

1. Web server returns “Hello World”.
2. Web server returns the list of files in the base directory.
3. Web server allows to navigate the directory structure.
4. If a user click on a file the browser should display it.

The only constraint he gave me was time: I had 60 minutes. After I heard the question I thought “Easy! 60 minutes seemed a long time and Ruby makes coding so much faster”. Well I was wrong I could not even complete milestone 3. I pretty much got lost for 35 minutes on the File and Directory APIs.
So I decided to finish the exercise in my spare time. It took me an other 45 minutes to complete the exercise. The hardest part was to remove 3 bugs (28 minutes!) all related to milestone 3.

See the end of the blog for the 5 seconds solution.

This is a great little exercise to learn Ruby and to exercise your coding skills so my suggestion is stop reading an get to work.

Here is how I did it:

1. Web server returns “Hello World”.

```ruby
require "socket"

webserver = TCPServer.new('localhost', 2000)
while (session = webserver.accept)
  session.write(Time.now)
  session.print("Hello World!")
  session.close
end

```

2. Web server returns the list of files in the base directory.

```ruby
require "socket"

webserver = TCPServer.new('localhost', 2000)
base_dir = Dir.new(".")
while (session = webserver.accept)
  session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
  base_dir.entries.each do |f|
    if File.directory? f
      session.print("
#{f}/

")
    else
      session.print("
#{f}

")
    end
  end
  session.close
end

```

3. Web server allows to navigate the directory structure.

First the solution I had after the 60 minutes interview.
(pretty bad!)

```ruby

require "socket"

webserver = TCPServer.new('localhost', 2000)
base_dir = Dir.new(".")
while (session = webserver.accept)
  session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"

  request = session.gets
  trimmedrequest = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '')
  if trimmedrequest.chomp != ""
    base_dir = Dir.new("./#{trimmedrequest}".chomp)
  end
  session.print "
#{trimmedrequest}

"

  session.print("#{base_dir}")
  if Dir.exists? base_dir
     base_dir.entries.each do |f|
       if File.directory? f
         session.print("<a href="#{f}"> #{f}</a>")
       else
        session.print("
#{f}

")
       end
     end
  else
    session.print("Directory does not exists!")
  end
  session.close
end

```

This is what I came up with in 10 minutes of coding and 28 minutes debugging. The bugs were related to my ignorance of the Ruby API in particular the File and Directory API, and a typos in the construction of the links: line 40 and 42 I forgot to add the “/” so the links were wrong but only I navigated down 2 levels in the directory hierarchies.


```ruby

require "socket"

webserver = TCPServer.new('localhost', 2000)
base_dir = Dir.new(".")
while (session = webserver.accept)
  request = session.gets
  puts request
  trimmedrequest = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
  resource =  trimmedrequest

  if resource == ""
    resource = "."
  end
  print resource

  if !File.exists?(resource)
    session.print "HTTP/1.1 404/Object Not Found\r\nServer Matteo\r\n\r\n"
    session.close
    next
  end

  if File.directory?(resource)
    session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
    if resource == ""
      base_dir = Dir.new(".")
    else
      base_dir = Dir.new("./#{trimmedrequest}")
    end
    base_dir.entries.each do |f|
      dir_sign = ""
      base_path = resource + "/"
      base_path = "" if resource == ""
      resource_path = base_path + f
      if File.directory?(resource_path)
        dir_sign = "/"
      end
      if f == ".."
        upper_dir = base_path.split("/")[0..-2].join("/")
        session.print("<a href="\&quot;/#{upper_dir}\&quot;">#{f}/</a>")
      else
        session.print("<a href="\&quot;/#{resource_path}\&quot;">#{f}#{dir_sign}</a>")
      end
    end
  else
     ## return file
  end
  session.close
end

```

4. If a user click on a file the browser should display it

This was pretty straight forward and it only took me 5 minutes since I copied the get_content_type from this blog post.

```ruby
require "socket"

def get_content_type(path)
    ext = File.extname(path)
    return "text/html"  if ext == ".html" or ext == ".htm"
    return "text/plain" if ext == ".txt"
    return "text/css"   if ext == ".css"
    return "image/jpeg" if ext == ".jpeg" or ext == ".jpg"
    return "image/gif"  if ext == ".gif"
    return "image/bmp"  if ext == ".bmp"
    return "text/plain" if ext == ".rb"
    return "text/xml"   if ext == ".xml"
    return "text/xml"   if ext == ".xsl"
    return "text/html"
end

webserver = TCPServer.new('localhost', 2000)
base_dir = Dir.new(".")
while (session = webserver.accept)
  request = session.gets
  puts request
  trimmedrequest = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
  resource =  trimmedrequest
  if resource == ""
    resource = "."
  end
  print resource

  if !File.exists?(resource)
    session.print "HTTP/1.1 404/Object Not Found\r\nServer Matteo\r\n\r\n"
    session.print "404 - Resource cannot be found."
    session.close
    next
  end

  if File.directory?(resource)
    session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
    if resource == ""
      base_dir = Dir.new(".")
    else
      base_dir = Dir.new("./#{trimmedrequest}")
    end
    base_dir.entries.each do |f|
      dir_sign = ""
      base_path = resource + "/"
      base_path = "" if resource == ""
      resource_path = base_path + f
      if File.directory?(resource_path)
        dir_sign = "/"
      end
      if f == ".."
        upper_dir = base_path.split("/")[0..-2].join("/")
        session.print("<a href="\&quot;/#{upper_dir}\&quot;">#{f}/</a>")
      else
        session.print("<a href="\&quot;/#{resource_path}\&quot;">#{f}#{dir_sign}</a>")
      end
    end
  else
    contentType = get_content_type(resource)
    session.print "HTTP/1.1 200/OK\r\nServer: Matteo\r\nContent-type: #{contentType}\r\n\r\n"
    File.open(resource, "rb") do |f|
      while (!f.eof?) do
        buffer = f.read(256)
        session.write(buffer)
      end
    end
  end
  session.close
end

```

The 5 Seconds Solution

```ruby
require 'webrick'

include WEBrick

puts "Starting server: http://#{Socket.gethostname}:#{port}"
server = HTTPServer.new(:Port=>2000,:DocumentRoot=>Dir::pwd )
trap("INT"){ server.shutdown }
server.start
```

Note: This post is copied from this [location](https://matteomelani.wordpress.com/2011/11/11/a-simple-web-server-is-ruby/). Finally, he got into **Twitter**.
