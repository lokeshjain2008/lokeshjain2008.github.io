---
layout: post
date: Wed Dec 21 15:35:33 2016
comments: true
title: Debugging JavaScript apps with vscode
---
# Debugging JavaScript/JavaScript apps with IDE(vscode).
We all as a JavaScript developer familiar with the tools to debug 
our `js` code in using `firebug` and `dev-tools`. there is a lot there 
to debug JavaScript in the dev-tools. Add a breakpoint and then 
to the code and more. But as `nodeJs` developer we miss the `IDE` support 
for the Debugging like putting breakpoint in the source files.

But, that was the past. Now, our friend `vscode` by microsoft  is the IDE
that we are seeking to get help with. 

In this post will list all the possible ways to debug our node/JavaScript apps.

### NodeJs
There are many ways to debug a node application.
Assume you have a script file `app.js`.

- `Debug` using node context in the comand line

```sh
node debug app.js
```
This command will put break point and will show us the context 
of the code node is running. There are more commands for help.
just type `help` in the console. to see the list of commands.

- `--inspect` to run the V8 in the `chrome`.
```sh
node --inspect app.js
node --inspect --debug-brk app.js //will create brk point on the line1.
```
This will give a debug url to  like this 

```
 To start debugging, open the following URL in Chrome:
chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=127.0.0.1:9229/80bcf82c-fc76-47ad-9514-1edb99940c0a
```
copy and past this url into the chrome browser and enjoy.

- Using `vscode`.
There is a lot of benefits of using vscode. Here is one more.
follow the link for more. I don't want to copy and paster.
  - [vscode debugging](https://code.visualstudio.com/Docs/editor/debugging)
  - [ionic2 app debugging using vscode](http://www.damirscorner.com/blog/posts/20161122-DebuggingIonic2AppsInChromeFromVisualStudioCode.html)





