---
layout: post
date: "Wed Mar 11 19:03:13 2015"
comments: true
title: "guard rspec is not working with vagrant"
tags: guard rspec vagrant
---
 # Gurad is not detecting any file chnage over vagrant files using shared nfs folders.
 I recently found out interesting issue with `guard-rspec`. 

 The listener detection is quite simple, it just checks the OS and if the OS specific adapter can be loaded. Since `Guard` comes with the adapter bundled, it will always chose `rb-inotify` as adapter on Linux.

 which was not working in your vagrant shared `nfs`. 

 ###Solution
Tell guard to fallback to polling for file changes. this is will be slow and will be pain if the project grows.

```ruby

guard -p

```
-p for polling.

Till now i know this trick to solve the issue. Hoping to find some good trick to solve this issue.

