---
layout: post
date: "Tue Mar 15 11:49:27 2016"
comments: true
title: "Angular minification safe DI (depedency injection)"
---

# Angular minification safe DI using gulp plugin.

According to `angular`

> Since Angular infers the controller's dependencies from the names of arguments to the controller's constructor function, if you were to minify the JavaScript code for controllers, services and modules. all of its function arguments would be minified as well, and the dependency injector would not be able to identify services correctly.

We can overcome this problem by annotating the function with the names of the dependencies, provided as strings, which will not get minified. There are two ways to provide these injection annotations:

1st method: Use an inline annotation

```javascript
angular.module('demo').controller(
'demoCtrl', [ '$sce', '$filter', '$scope', '$state', '$stateParams', '$window', 'RemoteClientData', 'toastr', '$locale', '$timeout', 'lodash', 'RegionSelector', 'EncryptPgp', 'PublicTfaAuthResource', 'FeeCalcResourcePublic', 'paymentMethodMapping', 'addressFieldsMapping', 'PaymentDraft', 'PaymentProcess', '$log', 'bbsetup', 'PayUtil', 'ErrorHandler', publicPaymentCtrl]);
//controller function
function publicPaymentCtrl($sce, $filter, $scope, $state, $stateParams, $window, RemoteClientData, toastr, $locale, $timeout, _, RegionSelector, EncryptPgp, PublicTfaAuthResource, FeeCalcResourcePublic, paymentMethodMapping, addressFieldsMapping, PaymentDraft, PaymentProcess, $log, bbsetup, PayUtil, ErrorHandler) {
	......... // reset is removed sake of brevity
}

```

2nd method: Create a $inject property on the controller function which holds an array of strings.
For example, same controller can be written as.

```javascript

publicPaymentCtrl.$inject = [ '$sce', '$filter', '$scope', '$state', '$stateParams', '$window', 'RemoteClientData', 'toastr', '$locale', '$timeout', 'lodash', 'RegionSelector', 'EncryptPgp', 'PublicTfaAuthResource', 'FeeCalcResourcePublic', 'paymentMethodMapping', 'addressFieldsMapping', 'PaymentDraft', 'PaymentProcess', '$log', 'bbsetup', 'PayUtil', 'ErrorHandler'];

angular.module('demo').controller(
'demoCtrl', publicPaymentCtrl]);
//controller function
function publicPaymentCtrl($sce, $filter, $scope, $state, $stateParams, $window, RemoteClientData, toastr, $locale, $timeout, _, RegionSelector, EncryptPgp, PublicTfaAuthResource, FeeCalcResourcePublic, paymentMethodMapping, addressFieldsMapping, PaymentDraft, PaymentProcess, $log, bbsetup, PayUtil, ErrorHandler) {
	.......// reset is removed sake of brevity.
}

```

Problem with both of the approach.
It will become very hard to keep track of the order in both the place and it is very easy to forget adding in the 2nd approach. In the development flow it will be easy to get it wrong as it won't b showing any error.
But in production there will b unexpected error and thaks to angular error reporting it won't even says what is actual problem.

## Automatic DI safe code generation.
There is a very good plugin for the `angular` app workflow.
[ngAnnotate](https://github.com/Kagami/gulp-ng-annotate)
It very easy to setup.

```javascript
var gulp = require('gulp');
var ngAnnotate = require('gulp-ng-annotate');

gulp.task('default', function () {
    return gulp.src('src/app.js')
        .pipe(ngAnnotate())
        .pipe(gulp.dest('dist'));
});


```


After this plugin inclusion our code become much clear and less to worry about the minification safe `DI` syntax.

```javascript

 angular
    .module('app.bb.controllers')
    .controller('bbCatCtrl', bbCategoriesCtrl);
  function bbCategoriesCtrl(Category, ErrorHandler, catObj, _, $timeout, $scope) {
  	//.......
  }

```

Final output after with the help of `ngAnnotate`.

```javascript

  bbCategoriesCtrl.$inject = ["Category", "ErrorHandler", "catObj", "_", "$timeout", "$scope"];
  angular
    .module('app.bb.controllers')
    .controller('bbCatCtrl', bbCategoriesCtrl);

  function bbCategoriesCtrl(Category, ErrorHandler, catObj, _, $timeout, $scope) {
    // Standard View-Model

}

```

Style 2: Inline functions.

Example:


```javascript

// original code
angular
    .module('app.rl.qtc')
    .controller('QtcCtrl', function QtcCtrlFunction($scope, BudgetDraft, userProfile, RecentActivities, Config, $cacheFactory, accountResource, $window) {
      'ngInject';
	});

```

Final output


```javascript

angular
    .module('app.rl.qtc')
    .controller('QtcCtrl', ["$scope", "BudgetDraft", "userProfile", "RecentActivities", "Config", "$cacheFactory", "accountResource", "$window",
    	function QtcCtrlFunction($scope, BudgetDraft, userProfile, RecentActivities, Config, $cacheFactory, accountResource, $window) {
      'ngInject';
      // code is removed for the sake of bervity.
		}]);

```

//Note:
'ngInject' is just a placeholder indicating automatic DI syntax inclusion.


### Caution:
---------
This gulp plugin will take care of safe DI, but there is one task that is not covered.
Resolve function in the Ui-router.

```javascript

.state('some',{
	...
	...
	resolve:{
	preReq: function($state, ....)
	}

});

```
Note: To Avoid DI error in production. We should use `ng-strict-di` directive.
This directive even gives a performance boot to `angular` apps.


in this case we have to do it manually.









