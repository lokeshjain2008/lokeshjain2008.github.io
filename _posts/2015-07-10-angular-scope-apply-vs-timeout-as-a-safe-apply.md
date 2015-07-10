---
layout: post
date: "Fri Jul 10 15:20:22 2015"
comments: true
title: "angular scope apply vs timeout as a safe apply"
---
`$timeout` and `$apply` in angular are mystery. There is question on stackoverflow about this mess.

#### Question
---
'm trying to better understand the nuances of using the $timeout service in Angular as a sort of "safe $apply" method. Basically in scenarios where a piece of code could run in response to either an Angular event or a non-angular event such as jQuery or some standard DOM event.

As I understand things:

- Wrapping code in $scope.$apply works fine for scenarios where you aren't already in a digest loop (aka. jQuery event) but will raise an error if a digest is in progress
- Wrapping code in a $timeout() call with no delay parameter works whether already in a digest cycle or not
Looking at Angular source code, it looks like $timeout makes a call to $rootScope.$apply().

1. Why doesn't $timeout() also raise an error if a digest cycle is already in progress?
2. Is the best practice to use $scope.$apply() when you know for sure that a digest won't already be in progress and $timeout() when needing it to be safe either way?
3. Is $timeout() really an acceptable "safe apply", or are there gotchas?
Thanks for any insight.

All questions are great and we get the best answer to all the questions.



#### Anaswer
---

> Looking at Angular source code, it looks like $timeout makes a call to $rootScope.$apply().
  - Why doesn't $timeout() also raise an error if a digest cycle is already in progress?


`$timeout` makes use of an undocumented Angular service `$browser`. Specifically it uses `$browser.defer()` that defers execution of your function asynchronously via `window.setTimeout(fn, delay)`, which will always run outside of Angular life-cycle. Only once `window.setTimeout` has fired your function will $timeout call `$rootScope.$apply()`.  

> Is the best practice to use $scope.$apply() when you know for sure that a digest won't already be in progress and $timeout() when needing it to be safe either way?

I would say so. Another use case is that sometimes you need to access a `$scope` variable that you know will only be initialized `after digest`. Simple example would be if you want to set a form's state to dirty inside your controller constructor (for whatever reason). Without `$timeout` the FormController has not been initialized and published onto $scope, so wrapping `$scope.yourform.setDirty()` inside `$timeout` ensures that FormController has been initialized.
 Sure you can do all this with a directive without `$timeout,` just giving another use case example.

 We had another use-case for this we are using google maps the maps view changes as we do some changes on type of map. Angular was not aware of the changes.
 So, `$timeout` was the rescue for the google maps with angular.

 >Is $timeout() really an acceptable "safe apply", or are there gotchas?
 
It should always be safe, but your go to method should always aim for $apply() in my opinion. The current Angular app I'm working on is fairly large and we've only had to rely on $timeout once instead of $apply().
