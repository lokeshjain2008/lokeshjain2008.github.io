---
layout: post
date: Tue Apr 12 22:35:18 2016
comments: true
title: "private properties in javascript using weekmap and symbols"
---

##private properties in javascript using weekmap and symbols

<strong>Unprotected scenario</strong>

Person instances created using the function below will have properties stored directly in them.


```javascript

var Person = (function() {
    function Person(name) {
        this.name = name;
    }
​
    Person.prototype.getName = function() {
        return this.name;
    };
​
    return Person;
}());
​
var p = new Person('John');
print('Person 1 name: ' + p.getName());
delete p.name;
print('Person 1 name: ' + p.getName() + ' — modified outside.');
//Execute
//Person 1 name: John
//Person 1 name: undefined — modified outside.

```

This approach has the advantage that all Person instances are similar and access to properties of those instances can be optimized. But on the other hand there are no private properties here — all object properties can be modified by external code (in this case — deleted).

Several libraries prefer to prefix properties that are intended to be private with the underscore character (e.g. _name). Others — like TypeScript — rely on the compiler to flag all illegal usages of a private property.

Hiding properties with closures

To isolate property from external modification one can use an inner closure that closes over the name variable. Douglas Crockford’s code conventions for JavaScript recommend this pattern when privacy is important discouraging naming properties with the underscore prefix to indicate privacy.

```javascript

var Person = (function() {
    function Person(name) {
        this.getName = function() {
            return name;
        };
    }
​
    return Person;
}());
​
var p = new Person('John');
print('Person 2 name: ' + p.getName());
delete p.name;
print('Person 2 name: ' + p.getName() + ' stays private.');
//Execute

```

The closure approach has an advantage of true privacy but the cost is that for each Person instance a new closure has to be created (the function inside the Person constructor).

Using Symbols

With ES6 there is one more way of storing properties — Symbols.

Symbols are similar to private names but — unlike private names — they do not provide true privacy.

To run the example your browser has to support:

```javascript

//ES6 Symbols

var Person = (function() {
    var nameSymbol = Symbol('name');
​
    function Person(name) {
        this[nameSymbol] = name;
    }
​
    Person.prototype.getName = function() {
        return this[nameSymbol];
    };
​
    return Person;
}());
​
var p = new Person('John');
print('Person 3 name: ' + p.getName());
delete p.name;
print('Person 3 name: ' + p.getName() + ' — stays private.');
print('Person 3 properties: ' + Object.getOwnPropertyNames(p));
 //Execute
//Person 3 name: John
//Person 3 name: John — stays private.
//Person 3 properties: 
```

Symbols do not increase the number of closures for each instance created. There is only one closure to protect the symbol.

Symbols are used to index JavaScript objects. The main difference from other types is that they are not converted to strings and exposed by Object.getOwnPropertyNames. Only using the symbol reference one can set and retrieve values from the object. A list of assigned symbols for a given object can still be accessed with the Object.getOwnPropertySymbols function.

Each symbol is unique — even if created with the same label.

ES6 Symbols

```javascript

var sym1 = Symbol('a');
var sym2 = Symbol('b');
var sym3 = Symbol('a');
​
print('sym1 === sym1: ' + (sym1 === sym1)); //false
print('sym1 === sym2: ' + (sym1 === sym2)); //false
print('sym1 === sym3: ' + (sym1 === sym3)); //false
```

Execute
Symbols have the following disadvantages:

Increased complexity in managing symbols 

— instead of simple p.name one first has to get the symbol reference and then use p[nameSymbol].
- Currently only a few browsers support symbols.
- They do not guarantee true privacy but can be used to separate public and internal properties of objects.
- It is similar to how most object-oriented languages allow access to private properties via the reflection API.

Private symbols are still considered for ECMAScript but the proper implementation that never leaks symbols is difficult. Private symbols are already used by the ES6 spec and are implemented internally in V8.

Using WeakMaps

Another approach to storing private properties involves WeakMaps.

An instance of WeakMap is hidden inside a closure and indexed by Person instances. The values in the map are objects holding private data.

ES6 WeakMaps

```javascript
var Person = (function() {
    var private = new WeakMap();
​
    function Person(name) {
        var privateProperties = {
            name: name
        };
        private.set(this, privateProperties);
    }
​
    Person.prototype.getName = function() {
        return private.get(this).name;
    };
​
    return Person;
}());
​
var p = new Person('John');
print('Person 4 name: ' + p.getName());
delete p.name;
print('Person 4 name: ' + p.getName() + ' — stays private.');
print('Person 4 properties: ' + Object.getOwnPropertyNames(p));
Execute
```

It is possible to use Map instead of a WeakMap or even a pair of arrays to mimic this solution. But using WeakMap has one significant advantage — it allows Person instances to be garbage collected.

The Map or an array holds objects that they contain strongly. Person is a closure that captures the private variable — that is also a strong reference. Garbage collector can collect an object if there are only weak references to it (or there are no references at all). Because of the two strong references as long as the Person function is reachable from the GC roots then every single Person instance ever created is reachable and thus cannot be garbage collected.

The WeakMap holds keys weakly and that makes both the Person instance and it’s private data eligible for garbage collection when a Person object is no longer referenced by the rest of the application.

Accessing properties of other instances

All presented solutions (with an exception of closures) have an interesting feature. Instances can access private properties of other instances.

The example below sorts Person instances by their names. The compareTo function uses the private data from both this and other instances.

ES6 WeakMaps

```javascript
var Person = (function() {
    var private = new WeakMap();
​
    function Person(name) {
        var privateProperties = {
            name: name
        };
        private.set(this, privateProperties);
    }
​
    Person.prototype.compareTo = function(other) {
        var thisName = private.get(this).name;
        var otherName = private.get(other).name;
        return thisName.localeCompare(otherName);
    };
​
    Person.prototype.toString = function() {
        return private.get(this).name;
    };
​
    return Person;
}());
​
var people = [
    new Person('John'),
    new Person('Jane'),
    new Person('Jim')
];
​
people.sort(function(first, second) {
    return first.compareTo(second);
});
​
print('Sorted people: ' + people.join(', '));
//Execute
// Sorted people: Jane, Jim, John
```
