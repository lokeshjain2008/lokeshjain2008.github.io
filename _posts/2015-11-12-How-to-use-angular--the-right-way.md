---
layout: post
date: "Thu Nov 12 15:30:00 2015"
comments: true
title: "How to use angular $resource the right way"
---

`Angularjs` is great javaScript framwork. Compared to other frameworks like `Ember` its more magical.
There is service called `$resource` in the `ngResource` module.

`$resource` is a great service when talking to `REST` servers. For the ROR developer is behave almost same the way
`resources` work there.
with the methods `edit`, `index`, `get` and `delete`.


The final output


```javascript

(function () {
  angular.modules('rl.qtc.services.ProductCatalogResource', ['ngResource'])
    .factory('ProductCatalogResource', function ($resource, Config) {

      return $resource(
        'productFamiliesUrl/:id',
        {bussinessId: '@businessId', cobrandId: '@cobrandId'},
        {
          query: {
            isArray: true,
            transformResponse: function (res) {
              return JSON.parse(res).filter(function (item) {
                return item.id < 12; //filter out 12legacy 13 promotions
              });
            }
          }
        }
      );
    });
}());

```


staget final-1




```javascript

(function () {
	angular.modules('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			'productFamiliesUrl/:id',
			{},
			{
        query:{
            isArray: true,
            transformResponse: function(res) {
             return JSON.parse(res).filter(function (item) {
               return item.id < 12; //filter out 12legacy 13 promotions
             });
            }
        },

		  get:{	method: 'GET',
				params: { bussinessId: '@businessId', cobrandId: '@cobrandId' },

			}
		  }
		);
	});
}());



```

final -2

```javascript

(function () {
	angular.modules('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			'productFamiliesUrl',
			{},
			{
        query:{
            isArray: true,
            transformResponse: function(res) {
             return JSON.parse(res).filter(function (item) {
               return item.id < 12; //filter out 12legacy 13 promotions
             });
            }
        },
				getProductFamily: {
					method: 'GET',
					params: { bussinessId: '@businessId', cobrandId: '@cobrandId' },
					url: 'productFamiliesUrl/:id'
				}
			}
		);
	});
}());





```


the original


```javascript

(function () {
	angular.modules('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			'productFamiliesUrl',
			{},
			{
				getFamilies: {
					method: 'GET',
					isArray: true,
					transformResponse: function(res) {
						var data = []
						angular.forEach((JSON.parse(res)), function(item){
							// filter out id 12("Legacy") and 13("Promotions")
							if (item.id < 12) {
								data.push(item);
							}
						});
						return data;
					}
				},
				getProductFamily: {
					method: 'GET',
					params: { bussinessId: '@businessId', cobrandId: '@cobrandId' },
					url: 'productFamiliesUrl/:id'
				}
			}
		);
	});
}());




```



Difference between `query` and `get`

get : needed an object in the response
query : allows a array in the response.


```javascript

	angular.modules('rl.qtc.services.budgetDraftResource', ['ngResource'])
	.factory('budgetDraftResource', function ($resource, Config) {
		return $resource(
			'/BudgetUrl',
			{},
			{
				getByAcctId: {
					method: 'GET',
					params: {accountId: '@accountId'},
					isArray: true
				},
				getById: {
					method: 'GET',
					url: Config.gatewayBaseUrl + '/draft-budgets/:draftBudgetId'
				},
				deleteById: {
					method: 'DELETE',
					url: Config.gatewayBaseUrl + '/draft-budgets/:draftBudgetId'
				}
			}
		);
	});

```

final output


```javascript


(function () {
  angular.modules('rl.qtc.services.budgetDraftResource', ['ngResource'])
    .factory('budgetDraftResource', function ($resource, Config) {
      return $resource(
        '/BudgetUrl/:draftBudgetId',
        {accountId: '@accountId'}
      );
    });
}());

```

See, how simple is to write a factory that make request to

- Get a single entity using id
- Query to get an array of data.
- send query params like `?query=accountId`
- delete an entity.


chears! happy javascript coding.
