---
layout: post
date: Wed Feb 25 17:10:15 2015
comments: true
title: edit-remote-host-file-with-sublime
tags: [sublime,script, bash script]
---
## How to edit remote file using our favourite editor `sublime`?

No, doubt `vim` is greate for file editing and other things. Still i want more freedom in terms of file editing oprions.

What Do I Do?
---
These instructions work for `Sublime Text 2/3`.  
If you don’t already have Sublime Text’s wonderful package manager, install it.
Hit Ctrl+Shift+P, start typing “install” and select “Install Package”
Start typing “rsub” and select it.
Once it’s installed, get on your terminal and do
`nano ~/.ssh/config`
Paste the following lines:

```bash
 Host your_remote_server.com
 RemoteForward 52698 127.0.0.1:52698
```    
Save (ctrl+w) and SSH into your server (ssh username@your_remote_server.com).
‘Install’ the rsub remote script:

```bash
sudo wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate
```
Make that script executable:

`sudo chmod +x /usr/local/bin/rsub`

Lastly, run rsub on the remote file you want to edit locally:

```bash
rsub ~/my_project/my_file.html
```
and it should magically open in Sublime Text!

There may be issue with saying localhost can't open file with rmate then do the following trick to make this work.

```bash
ssh -R 52698:localhost:52698 <user>@<remotehost>
```