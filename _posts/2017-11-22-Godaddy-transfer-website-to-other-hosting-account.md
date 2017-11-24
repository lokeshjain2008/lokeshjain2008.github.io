---
layout: post
date: Wed Nov 22 15:08:11 2017
comments: true
title: Godaddy transfer website to other hosting account
tags: godaddy, transter hosting plan to shared hosting
---
 
I have a friend, who has a godaddy account and posses a domain name with personal hosting including free email address.
As being ad developer I have a share linux hosting plan. So, it becomes cheeper for him to have hosting with my hosting plan.
So, he decided to move his website with my hosting plan.
Steps to achieve this.
1. add him as a client.
2. after the approval add a add on domain entry in the hosting plan.
3. copy the wp-content lib using ftp for the old website hosting.
4. Login to old website using wp-admin and navigate to `tools>export` and export content.
5. Create a wordpress website on hosting panel(C-panel) for the website.
6. go the website `DNS` setting and update `A` record with the new IP.
7. Replace the content.




