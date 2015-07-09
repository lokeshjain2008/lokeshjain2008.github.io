---
layout: post
date: "Mon Jun 15 13:00:03 2015"
comments: true
title: "JavaScript singleton patterns"
---
I was interested in javascript `singleton-design-pattern`. Here i got some patterns for the pattern.

1. from viral patel blog.

```javascript

var Sun = (function(){
              var sunInstance; //private variable to hold the
                               //only instance of Sun that will exits.

              var createSun = function(){
                         var privateMass = 10000000000; //private
                         var looseMass = function(mass){
                             privateMass -= mass;
                         }
                         var publicEmitLight = function(){
                                  //some complex Nuclear fission
                                  //calling looseMass()
                                  looseMass(10);
                         };
                         var getMass = function(){
                                  return privateMass;
                         };
                         return {
                                emitLight: publicEmitLight,
                                getMass: getMass
                         };
              };

              return {
                    getInstance: function(){
                          if(!sunInstance){
                              sunInstance = createSun();
                          }
                          return sunInstance;
                    }
              };
})();


```

explanation
----
The Sun variable will be assigned what this return statement evaluates to. And clearly, this evaluate to an object with only one property of type function: getInstance. So whenever we need to obtain an instance of sun in our code, all we do is use:

-----

####patttern 2:

```javascript


var singleton = (function() {
  var privateData = "foo"
  var privilegedMethod = function() {
    return privateData;
  };

  var why = {
    not: "just",
    create: "a",
    literal: "object",
    with: privilegedMethod
  };

  return why;
}());

console.log(singleton.privateData); // => undefined
console.log(singleton.with()); // => "foo"


```


----

patttern 3. [link](http://jsfiddle.net/X2u6n/6/) Returning only instance.







