
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
with the methods `update`, `index`, `new` and `delete`.


The final output


```javascript

(function () {
  angular.rlmodule('rl.qtc.services.ProductCatalogResource', ['ngResource', 'rl.qtc.Config'])
    .factory('ProductCatalogResource', function ($resource, Config) {

      return $resource(
        Config.gatewayBaseUrl + '/product-families/:id',
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
	angular.rlmodule('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			Config.gatewayBaseUrl + '/product-families/:id',
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
	angular.rlmodule('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			Config.gatewayBaseUrl + '/product-families',
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
					url: Config.gatewayBaseUrl + '/product-families/:id'
				}
			}
		);
	});
}());





```


the original


```javascript

(function () {
	angular.rlmodule('rl.qtc.services.ProductCatalogResource', ['ngResource','rl.qtc.Config'])
	.factory('ProductCatalogResource', function($resource, Config) {

		return $resource(
			Config.gatewayBaseUrl + '/product-families',
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
					url: Config.gatewayBaseUrl + '/product-families/:id'
				}
			}
		);
	});
}());




```



Difference between `query` and `get`

get : needed an object in the response
query : allows a array in the response.




	angular.rlmodule('rl.qtc.services.budgetDraftResource', ['ngResource', 'rl.qtc.Config'])
	.factory('budgetDraftResource', function ($resource, Config) {
		return $resource(
			Config.gatewayBaseUrl + '/draft-budgets',
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



final output


```javascript


(function () {
  angular.rlmodule('rl.qtc.services.budgetDraftResource', ['ngResource', 'rl.qtc.Config'])
    .factory('budgetDraftResource', function ($resource, Config) {
      return $resource(
        Config.gatewayBaseUrl + '/draft-budgets/:draftBudgetId',
        {accountId: '@accountId'}
      );
    });
}());

```




