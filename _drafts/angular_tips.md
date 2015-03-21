---
layout: post
comments: true
--- 
Angular form the codeschool videos.

1. `ng-show/ng-hide`
2. for the Images to load `ng-src`
3. `ng-click` and there is more attached to it. `ng-href` if we want to open that link..
4. `ng-init` for initializing the values for the object.
eg. 

```html
<section ng-init="tab=1">
	<ul class="nav">
		<li ng-click="tab=1">value 1</li>
		<li ng-click="tab=2">value 2</li>
		<li ng-click="tab=3">value 3</li>
	</ul>
</section>
```
5. `ng-class`

```html
<li ng-class="{active:tabl===1}">
	<a href="#" ng-click="tab=1"></a>
</li>

```
There are more cases for the ng-class like more classes to show and more conditions

```html
<div ng-class="{'class1' : expression1, 'class2' : expression2}">
    Hello World!
</div>
<!-- To apply multiple classes when an expression holds true: -->

<!-- notice expression1 used twice -->
<div ng-class="{'class1' : expression1, 'class2' : expression1}">
    Hello World!
</div>
<!-- or quite simply: -->

<div ng-class="{'class1 class2' : expression1}">
    Hello World!
</div>
```

5. `ng-repeat` there is some magic variables like. 
	- `$index`
	- `$first`
	- `$last`
	
	```html 
	<div ng-repeat="item in [1, 2, 3, 4, 5]" ng-class="{ first: $first, last: $last };" class="count-{{$index + 1}}">{{item}}</div>

	```
	Above snippet add class `first` only for the first iteration and likewise.
6. 

```javascript
var app = angular.module('app',[]);
app.directive('directive',function(){
	return {
		restrict: 'EAC',
		replace: true, 
		templateUrl: '#',
		controller: function($scope,$element){

			},
			controllerAS: ctrl,
			link:function(scope,element,attrs){

			}
	}
	});

```
7. `ng-include` This will include html template this require to include string using ''.

```html
	<div class="panel" ng-include="'header.html'"></div>
```

8. Factory, Service vs Provider
8.1 Factory is link Service you need to return factory object. 
	prpperties are defined on the private variable `factory` in the example.

```javascript
var app = angular.module('app',[]);
//craete a factory that will return the data 
app.factory('myFactory',function($http){

	var factory = {};
	
	factory.getProduct = function(){
		return $http.get('/friends.json');
	};
	return factory;
	});

	//Now this factory can be used in the controller 
	
	app.controller('Ctrl',function($scope,myFactory){
		 $scope = myFactory.getProduct();
		});
```
`service` just like factory and prpperties are definded the `service` object.

```javascript
app.service('myService',function(){
	 var private  = "Private value";
	 this.getProduct = function(){
	 	$http.get('/products.json');
	 }
	});
```

10. Basic angaluar directives and examples to use them.
	
