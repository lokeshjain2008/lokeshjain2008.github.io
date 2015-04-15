---
layout: post
date: "Wed Apr 15 15:57:13 2015"
comments: true
title: "getting started with bower and gulp"
---

`bower` is the easiest to get started with 

just do 


```
sudo npm install bower -g

```
Now, do


```sh
bower init
//Now answer to the questions that will b asked...

```
to install the libraries just so 


```sh
bower install angular#1.3.0 --save 

```
Now, this `angular#1.3.0` will be added in your bower.json file

---
### [Gulp](http://gulpjs.com/)

Getting started with is also easy. 

#### Step-1

```sh 
npm install --save-dev gulp

touch gulpfile.js

```
### Step-2 
Create and open `gulpfile.js` and follow.

```JavaScript

var gulp = require('gulp');

gulp.task('two',function(){

 	console.log("Hye this is task: two");
});


 gulp.task('one', function one_task (argument) {
 	console.log("This is one task");
});


 //Create `default` task that will be called when we invoke `gulp`.

 gulp.task('default',function(cb){
 	console.log('Hey this is default function');
 });

```

Now `one`, `two` will be called.

```javascript

gulp.task('default',['one', 'two']);

```
Note: what comes last will over write the perv. task.


Added some real work with the gulp..
For this gulp has rich Plugin store. [link](http://gulpjs.com/plugins/)

```javascript
var gulp = require('gulp'),
	uglify = require('gulp-uglify');

//Note: before using please install uglify.
//using

// `npm install --save-dev gulp-uglify`
// This will install the package in project specific folder only

gulp.task('asset:uglify',function(){
	return gulp.src('js/*js')
	.pipe(uglify())
	.pipe(gulp.dest('public/'));
});

```
hmm... that is good. Now i can uglify my js files using `gulp` task.
It would be nicer if gulp do it when there is change a in any file.
For this we have watches to do that for us.

```javascript
gulp.task('watch:asset', function(){
	gulp.watch('js/*js',['asset:uglify']);
});

```
Call this is in terminal and it will be watching for changes in the specified files and will
be running `asset:unglify` for it. Yahoo! we are good but wait lets check if there is any error in the process then what we get.
I have made a mistake in one my js file and gulp stops.
 ![see-image](http://i.imgur.com/aboi1Ni.png)

What we do now.

```javascript
gulp.task('asset:uglify',function(){
	//note don't user `return` keyword that may break this code.
	gulp.src('js/*js')
		.pipe(uglify())
		.on('error',console.log.bind(console)) //Error handling and 
		.pipe(gulp.dest('public/'));
});

```

Now every thing works as expected.
 ![see-this](http://i.imgur.com/zHoVvlY.png) 

You may get some errors. See this [link](https://github.com/gulpjs/gulp/issues/259).


Alternate solution will be like using [plumber](https://www.npmjs.com/package/gulp-plumber/)



	


