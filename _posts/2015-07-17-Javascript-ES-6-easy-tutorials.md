---
layout: post
date: "Fri Jul 17 09:47:28 2015"
comments: true
title: "ES6 Javascript with examples",
tags: [Javascript, es-6, es6, tutorial]
---


transform: translateZ(0);
```javascript
  var animationPlayer = $0.animate([{
    transform: 'translateX(0px)'
  }, {
    transform: 'translateX(600px)', offset: 0.416
  }, {
    transform: 'translate(600px, 20px)'
  }], 3000);

  animationPlayer.onfinish = function(e) {
    console.log('complete!');
  }
  animationPlayer.onfinish(e);
```
----
### React core concept.
- for every dom element, there's a component.
- no templates at runtime . only javasscrpt.
- data flows only in the one direction. down the tree
- conceptually, we never update or mutate do re-render


### ES-6 core concept with exmaples.
I heard longtime ago that new JavaScript is coming. There are lot of buzz around it. I was waiting to use it code but no browser supports it fully.
Till then i kept waiting until people started to say ES-6 is old ES-7 is coming but i haven't learnt ES-6.

So, i kept reading about it but forget every time i read it as there are very few examples about it.
I fount very good resource to try out new features [Website](http://www.es6fiddle.net/).
Copy, Paste and run code there to follow.

- Arrow Function [link](http://www.es6fiddle.net/icg0vhk0/)

```javascript

//Don't worry about the `let` is like `var`
// with block scope only.

let square = x => x * x;
let add = (a, b) => a + b;
let pi = () => 3.1415;

console.log(square(5));
console.log(add(3, 4));
console.log(pi());

//new way to create IIFE(immedidatly invoked
//funtion expression)


((w)=>{

  w.go =(name) => `go ${name}`;

})(window);


let me = window.go('Javascript Lover');

console.log(me);

//Question: Do we really need IIFE ? as ES-6 has module
//loader Please reply in the comment.

//Use of `Arrow functions`
// It's a shorthand to write anonymous function
var arr = [1,2,2,3,5];

var oldArr = arr.map(function(el){ return el+1});

console.log(oldArr);

// new way
var newArr = arr.map(el=>el+1); //short hmm..
console.log(newArr);


// Lexical this
var bob = {
  _name: "Bob",
  _friends: [],
  printFriends() {
    this._friends.forEach(f =>
      console.log(this._name + " knows " + f));
  }
}

```

- `let` and `const` [link](http://www.es6fiddle.net/icg51264/)
Note: we have already used let above

example 1:
```javascript
var x = 0;

{
  var x = 10; // this block will change the value of x
  // although this was declared in the block

}

console.log(x); // 10
```

example 2:

```javascript
//Here comes the let


var y = 9;

{
  let y = 99;
  console.log("Y in block",y); // 99
}

y; // 9

```

example 3:

let stops you to create same variable by accident

```javascript
{
  var test = "a";
  var test = "b"; // No, error, you reinitialize the value using var
}

//Let won't allow you to do so

{
 let test = "more";
  let test = "can't change"; //Error. Duplicate declaration
}

```
The question is why we need it. see the following examples. They are used to test javascript candidate.

```javascript

// why you need it.
var fs =  [];
for (var i = 0; i < 10; i++) {
    let f = ()=>i;
    fs.push(f);
}

//fs.forEach((el)=> console.log(el())) // all will be 10: as every this i is reinitialized

fs = [];
for (let i = 0; i < 10; i++) {
    let f = ()=>i;
    fs.push(f);
}


fs.forEach((el)=> console.log(el())) // Yahoo we get the correct sequence..

//another example timeout

for(var i =0; i<5; i++){

  setTimeout(function(){
    console.log("timeout called",i);
  },1000*i);

  //will output timeout called 5 all time.
}

// classic solution

for(var i =0; i<5; i++){

(function(i){
  setTimeout(function(){
    console.log("timeout called Correct",i);
  },2000*1);
 }(i));
  //Used closure to get the desired output.
}

//es6 No need to worry

for(let i =0; i<5; i++){

  setTimeout(function(){
    console.log("timeout called--ES-6",i);
  },2000*i);

  //No worries ... :)
}
```

What about the const now.
They are the constant you can't change the value again

```javascript
{
 const EXMAN = "Lokesh kumar jain";
}

console.log(EXMAN); // EXMAN is not defined

```
SO, `const` has block level scope like `let`.

```javascript
{
 const EXMAN = "Lokesh kumar jain";

  EXMAN = "super man"; //Error const is read-only
}
//EXMAN is read-only
```

- Default Values for Function Parameters and string interpolation.

There are some functions that want input, sometimes you don't have or there can be default input to the function.
cut the crap see the example.

```javascript
 var greet = function (name="God", message="Welcome"){
   return `${name} this is string interpolation. Now, you are ${message}`;
 };

 console.log(greet()); // now function will take defatult values. You can override them.

 //God this is string interpolation. Now, you are Welcome

```
Note: `$` in the string interpolation won't conflict with jQuery's `$`.


- Classes and inheritance [link](http://www.es6fiddle.net/icg61vfs/)

```javascript
class Polygon {
	constructor(height, width) { //class constructor
		this.name = 'Polygon';
		this.height = height;
		this.width = width;
	}

	sayName() { //class method
		console.log('Hi, I am a', this.name + '.');
	}
}

class Square extends Polygon {
	constructor(length) {
		super(length, length); //call the parent method with super
		this.name = 'Square';
	}

	get area() { //calculated attribute getter
		return this.height * this.width;
	}

  static lib(){
   console.log("Hi, will be called with class only")
  }

}

let s = new Square(5);

s.sayName();
console.log(s.area);

console.log(Square.lib()); //Calling static function

//This is same like
function Square(){
}
Square.lib =  function(){};

```

- De-structured Assignment  [link](http://www.es6fiddle.net/icg6dste/)

```javascript
let [one, two] = [1, 2];
let {three, four} = {three: 3, four:  4};

console.log(one, two, three, four);


var a = ({message:x})=> console.log(x);


a({message: "Hey this is message man"});


let b = (a,b,c) => console.log(a+b+c);
b(...[1,2,3]); //spread operator


let rest =  function (one,...rest){
 console.log(one,rest);
  //1 [2, 3, 77, 4, 5]
}
rest(1,2,3,77,4,5);
//we don't need `arguments` variable now.

let [on,tw] = [1,2,3,4];
console.log(on,tw); // 1 ,2 //other ignored.

let [ok,...all] = [1,2,3,4];

console.log(ok,all); //1 [2, 3, 4]


```
