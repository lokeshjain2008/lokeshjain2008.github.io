
---
layout: post
date: Thu Mar 19 14:15:07 2015
comments: true
title: angularjs form validation handling using
---
 Angualr js do form validation very verbose way but still you need to add more.
$scope.familyForm.$setValidity(submit,false);
complete this using this reference https://docs.angularjs.org/api/ng/type/ngModel.NgModelController

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

