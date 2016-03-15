---
layout: post
date: "Sun Jan 10 12:41:14 2016"
comments: true
title: "getting started with Node.js"
tags:
  - Node.js
  - JavaScript
---

let's assume we have installed `node` and `npm`.

First Node.js code. we will b writing very basic hello world program using `Node.js`.
Follow the Following steps.
1. create one file and name it `one.js`.
2. write Following code `console.log("Hello world")`;
3. Goto the terminal and type `node one.js`.

you will see Following output.
--

```bash
  Hello world
```

Note:
Node.js is a wrapper around `v8 javascript engine` written in C. Node.js provides a hosting environment for the `V8` engine. For the `systme input and output` node uses `process`.

The upper code can be written as

```javascript
//one.js
process.stdout.write("Hello World \n");

```

will output the same.

for reading input from the command line `process.argv`.

for this reason we read sensitive data as `process.env.data`.

#### Node.js as command line util function
put the following in the file at the first line

`#!/usr/bin/env node`

then the file will become bash script.

e.g.

```bash
//1.js

#!/usr/bin/env node
console.log("Hey I will b working as a bash script");
```
Then make this file executable using `chmode 700 1.js`

```bash
./1.js
#output -----
```

#### Nature of Node.js function
Node.js has error first philosophy so, first argument of a program will be `error`
variable.

```javascript
var fs = require('fs');
content = fs.readfileSync('somefile.txt');
//Note all function in the module are `async` in nature

//Note:: if we do
console.log(content); // this will print Array Buffer to the screen.
//Make array buffer to print the file content do
console.log(content.toString()); // this will print our desired output.

//Async way
fs.readfile('somefile.txt',function(error, content){
  if(error){
    console.error(error);
    return; // exit(1)
  }else{
    console.log(content.toString()); //?? toString :: see above(read this code with the comments).
  }
});

```
Note all function in the module are `async` in nature if you want `sync` then use
Sync with the functions.

#### Node REPL commands.

There are a few special REPL commands:

- `_` Will hold the value of the last output in the REPL.
  e.g. `let arr = [1,2,3,34]; console.log(_);`

- .break - While inputting a multi-line expression, sometimes you get lost or just don't care about completing  it. .break will start over.
- .clear - Resets the context object to an empty object and clears any multi-line expression.
- .exit - Close the I/O stream, which will cause the REPL to exit.
- .help - Show this list of special commands.
- .save - Save the current REPL session to a file
- .save ./file/to/save.js
- .load - Load a file into the current REPL session.
- .load ./file/to/load.js

#### Global variables in Node.js
-  __filename
-  __dirname
-  for more follow the [link](https://Node.js.org/api/globals.html)

Just for reference in `ruby`

-  __ FILE __
-  __ dir __
-  __ method __
_  __ callee __
-  __ LINE __

#### `exports` and `module.exprots`

```javascript
exports.sayHelloInEnglish = function() {
  return "HELLO";
};

exports.sayHelloInSpanish = function() {
  return "Hola";
};

```

This can be written as


```javascript

module.exports = {
  sayHelloInEnglish: function() {
    return "HELLO";
  },

  sayHelloInSpanish: function() {
    return "Hola";
  }
};

```

#### File streams in the Node.js
Here is the link for both file stream and pipe in Node.js
i dint' want to repeat follow the [link](http://www.sitepoint.com/basics-node-js-streams/)


#### miscellaneous
1. offline `npm` follow the [link](https://addyosmani.com/blog/using-npm-offline/)
