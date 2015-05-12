---
layout: post
date: Thu Mar 19 14:15:07 2015
comments: true
title: angularjs form validation handling using
---

Angualr js do form validation very verbose way but still you need to add more.
`$scope.familyForm.$setValidity(submit,false);`

complete this using this [reference](https://docs.angularjs.org/api/ng/type/ngModel.NgModelController)

But don't forget to pass valid condition for our new validation. I faced problem saving form i was'nt supplying the passing condition to the validation.


```javascript
$scope.<form-name>.$setValidity('submit',false);
//this will make form whole form invalid.
//so, $scope.<form-name>.$valid  will be false

//if all your conditions are matched then make is valid.

if(my_conditions){
	$scope.<form-name>.$setValidity('submit',true);
}
```


### `$broadcast` and `$emit` in angaular js.

- `$broadcast` goes from top to bottom or parent to all children.
- `$emit` travels from child to parent.
- `$on` will get the message and act on it.

```javascript

$scope.$broadcast('will_go_down',{
	data: 'all children come home'
});

$scope.$on('will_go_down',function(){
	return 'coming';
});

$scope.$emit('get_me_home',{
	data: 'father take me home'
});

$scope.$on('get_me_homw',function(){
	return 'do it by your self';
});

```

### create and destroy the `scope` in angaular

careating a new scope is simple
`var new_scope = scope.$new() `

and destroy with `$destroy`

`new_scope.$destroy()`
to stop memory leak due to scopes in angaular. It developer duty to handle created scope./

Here is good link for this: [link](http://www.toptal.com/angular-js/videos/javascript-video-tutorial-using-destroy-to-clean-up-scopes-in-angularjs)


### Watching for changes in angularjs there are following for this.
- `$watch`

	```javascript
	$scope.$watch('prop',function(newValue, oldValue){

	});

	```
- `$watchGroup` If we want to watch more than one property

	```javascript

	$scope.$watchGroup(['propOne','prop2'],function(newValues, oldValues){

	});
	```
- `$watchCollection` Two watch the array or complex data.


### Angular wise choose for the function.
- `$digest` is better than `$apply`.
- `$observe` is faster than `$watch`. as `$watch` will run two to functions to complete the task one for comparision and then for the callback.


----
### Angular Testing
----
1. Testing it good for the project to gain confidance about the coding.

lets try to write testing for the following code `directive`.

```javascript

(function(){
  'use strict';
  angular
    .module('rl.directive',[])
    .directive('campaignInstruction',[function(){
      return{
        restrict: 'E',
        scope: {
          product: '='
        },
        templateUrl: 'camp_inst.html',
        link: linkFunction,
        controller: ['$scope', campaignInstruction],
        controllerAs: 'campIns'
       // bindToController: true
      };

      function linkFunction(scope, element, attrs){

      }

      function campaignInstruction($scope, offerFactory, advertiserFactory){
        /* jshint validthis: true */
        var vm = this;
        vm.someValues = [1,2,3,4];
        vm.offerTypes = offerFactory;
      }

    }]);
}());

```
This directive has templateUrl with this.







