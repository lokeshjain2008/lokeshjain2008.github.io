---
layout: post
title: angular
comments: true
---

#Learning the angular for the good reasons

```javascript
$rootScope and scope in angular
$rootScope.age = 15;
$scope.age = 52;

var element = $compile("<div>Tom is {{age}}</div>")($rootScope);
/* element is a div with text "Tom is 15" */

var element2 = $compile("<div>Tom is {{age}}</div>")($scope);
```

`$rootScope` var which points to the parent of all the scopes and can be injected everywhere. All other scopes are children of the `$rootScope`. They are created via the `$new` method of the $rootScope thus 
>every scope inherits from the $rootScope.

$compile in has been in the above example
ng-bind-html-unsafe for the escaping of html.
$digest: 

# Learning form the code this is about  the routing 

```html
<!-- note: ui-sref for the navigation only -->
<a ui-sref="home">Home</a></li>

<div class="container" ng-app="app">
  <header ng-include="'nav.html'"></header>
  <div ui-view></div>
  <footer ng-include="'footer.html'"></footer>
</div>
```

```javascript
 angular
  .module('app', [
    'ui.router'
  ])
  .config(['$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
    $urlRouterProvider.otherwise('/');
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'home.html',
        controller: 'homeCtrl'
      })
      .state('about', {
        url: '/about',
        templateUrl: 'about.html',
        controller: 'aboutCtrl'
      })
  }])

```
In the above code the navigation has been taken careof
Now we need controllers for the inspection

```javascript
//home controller for the routers..

angular
  .module('app')
  .controller('homeCtrl', ['$scope', 'Friends', function($scope, Friends) {
    $scope.title = "Home";
    //Friends is a Factory to  git us data and the promise
    Friends.get().then(function(data) {
      $scope.friends = data;
    });
    $scope.items = ['home','about','contact'];
    $scope.selectedValue = 'home';

    $scope.save = function() {
      $http.post('/api/friends', friends);
    };
  }]);

```

```javascript
// Factory to return data  and this can be used now every where for the data sending and more..
angular
  .module('app')
  .factory('Friends', ['$http', function($http) { // for http request and promise to be resolved
    return {
      get: function() {
        return $http.get('/2iZpG87HNCsNxagG/friends.json').then(function(response) {
          return response.data;
        });
      }
    };
  }])
```


# Angular directive

[Get scope in angalur](http://stackoverflow.com/questions/13743058/how-to-access-the-angular-scope-variable-in-browsers-console?rq=1)

####Note

@ --> Attribute string binding
= --> Two-way model binding
& --> Callback method binding
The symbols also make it clearer as to what the scope variable represents inside of your directive's implementation:

@ --> string
= --> model
& --> method

### Another way of routing in the app
`ng-route` we need to included this file for DI.

```javascript
app.module('app',['ngRoute'])
	.config(['$routeProvider',function routeConfig($routeProvider){
		$routeProvider.
      when('/phones', {
        templateUrl: 'partials/phone-list.html',
        controller: 'PhoneListCtrl'
      }).
      when('/phones/:phoneId', {
        templateUrl: 'partials/phone-detail.html',
        controller: 'PhoneDetailCtrl'
      }).
      otherwise({
        redirectTo: '/phones'
      });
		}]);
```
Note: look at `$routeProvider` in the angalur `config` we can add `Providers` for the early access and cofiguraions. Rest it will be service `$route`

```javascript
app.controller('Controller',function($scope,$route){});
``` 
#### Route Params for the urls and accessing them.
there is route defined as.

```javascript
app.config(function($routeProvider) {
    $routeProvider
      .when('/map/:country/:state/:city',
      {
        templateUrl: "app.html",
        controller: "AppCtrl"
      })
});
// `$routeParams` will give the url query values
app.controller("AppCtrl", function($scope, $routeParams) {

    $scope.model = {
        message: "Address: " +
          $routeParams.country + ", " +
          $routeParams.state + ", " +
          $routeParams.city + ", "
    }
});

```
Note: for the routing following will be there. `routeParams`, `path` and `search`

```javascript
otherwise({
        redirectTo: function(routeParams,path,search){

        }
      });


```

### See changes in angular. for the changes observation we have `$watch`

```javascript

$scope.$watch('model',function(new_value,old_vlaue){},
		true // for the deep check on the model values
		)

```

### `$templateCache`

An alternative to inject an AngularJS template by using $templateCache, using .get() and .put() methods.

### Routing and Error handing for the route error.

[video](https://egghead.io/lessons/angularjs-resolve-routechangeerror)

### Learning form the video.

```javascript

//in the routing and it can be used in the controller
resolve: {
	preData : loaderCtrl.data()
},
template/templateUrl : "Hello this is template"

// data is mapped to the controller as...
.controller('viewCtrl',function($scope,preData,$tempale){

	});

```










