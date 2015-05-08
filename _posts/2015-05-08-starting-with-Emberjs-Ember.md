---
layout: post
date: "Fri May  8 10:21:55 2015"
comments: true
title: "starting with Emberjs Ember"
---
Ember is a greate `mvc` javascript framework.
below is the code to understans this.

```html

<!DOCTYPE html>
<html>
<head>
  <base href='http://courseware.codeschool.com/ember/' />
  <link href='bootstrap.css' rel='stylesheet' />
  <link href='application.css' rel='stylesheet' />
  <script src='jquery.js'></script>
  <script src='handlebars.js'></script>
  <script src='ember.js'></script>
  <script src='ember-data.js'></script>
  <script src='app.js'></script>
</head>
<body>
  <script type='text/x-handlebars' data-template-name='application'>
    <div class='navbar navbar-default'>
      <div class='container'>
        {{#link-to 'index' class='navbar-brand'}}<img src='images/logo.png' alt='logo' height='34' width='224' />{{/link-to}}
        <ul class='nav navbar-nav navbar-right'>
          {{#link-to 'index' tagName='li'}}Home{{/link-to}}
          {{#link-to 'products' tagName='li'}}Products{{/link-to}}
          {{#link-to 'contacts' tagName='li'}}Contacts{{/link-to}}
        </ul>
      </div>
    </div>
    <div class="container">
      {{outlet}}
    </div>
    <footer class='container'>
      <hr />
      <p class='pull-left'>&copy; 2013 The Flint &amp; Flame</p>
      <p class='pull-right'>{{#link-to 'credits'}}Credits{{/link-to}}</p>
    </footer>
  </script>
  <script type='text/x-handlebars' data-template-name='index'>
    <div class="jumbotron">
      <h1>Welcome to The Flint &amp; Flame!</h1>
      <p class="tagline">
        <img {{bind-attr src='logo'}} alt='Logo' />
        Everything you need to make it through the winter.
      </p>
      <p>
        {{#link-to 'products' class='btn btn-primary btn-lg'}}
          Browse All {{productsCount}} Items &raquo;
        {{/link-to}}
      </p>
    </div>
    <p class='pull-right text-muted'>Rendered on {{time}}</p>
  </script>
  <script type='text/x-handlebars' data-template-name='contacts/index'>
    <div class='row'>
      <img {{bind-attr src='avatar'}} alt='Avatar' class='img-thumbnail col-sm-4'/>
      <div class='col-sm-8'>
        <h1>About The Fire Sprites</h1>
        <p>Contact {{contactName}} for more info!</p>
        <p>Current Status: {{open}}.</p>
      </div>
    </div>
  </script>
  <script type='text/x-handlebars' data-template-name='credits'>
    <h1>Thanks for the Help!</h1>
    <p>This site would not be possible without the hardworking Ember Core Team!</p>
  </script>
  <script type="text/x-handlebars" data-template-name='products'>
    <div class='row'>
      <div class='col-sm-3'>
        <div class='list-group'>
          {{#each}}
            {{#link-to 'product' this classNames='list-group-item'}}
              {{title}}
            {{/link-to}}
          {{/each}}
        </div>
      </div>
      <div class='col-sm-9'>
        {{outlet}}
      </div>
    </div>
  </script>
  <script type='text/x-handlebars' data-template-name='product'>
    <div class='row'>
      <div class='col-sm-7'>
        <h2>{{title}}</h2>
        <h3 class="text-success">${{price}}</h3>
        <p class="text-muted">{{description}}</p>
        <p>Finely crafted by {{#link-to 'contact' crafter}}{{crafter.name}}{{/link-to}}.</p>

        <h3>Reviews</h3>
        <ul>
        {{#each reviews}}
          <li><p>{{text}}</p></li>
        {{else}}
          <li><p class='text-muted'><em>No reviews yet. Be the first to write one!</em></p></li>
        {{/each}}
        </ul>
      </div>
      <div class='col-sm-5'>
        <img {{bind-attr src='image'}} class='img-thumbnail img-rounded'/>
      </div>
    </div>
  </script>
  <script type='text/x-handlebars' data-template-name='products/index'>
    <p class='text-muted'>Choose a product from those on the left!</p>
  </script>
  <script type="text/x-handlebars" data-template-name='contacts'>
    <div class='row'>
      <div class='col-sm-9'>
        {{outlet}}
      </div>
      <div class='col-sm-3'>
        <div class='list-group'>
          {{#each}}
            {{#link-to 'contact' this classNames='list-group-item'}}
              {{name}}
            {{/link-to}}
          {{/each}}
        </div>
      </div>
    </div>
  </script>
  <script type='text/x-handlebars' data-template-name='contact'>
    <div class='row'>
      <div class='col-sm-5'>
        <img {{bind-attr src='avatar' alt='name'}} class='img-thumbnail img-rounded'/>
      </div>
      <div class='col-sm-7'>
        <h2>{{name}}</h2>
        <p>{{about}}</p>

        <h3>Products</h3>
        <ul>
        {{#each products}}
          <li>{{#link-to 'product' this}}{{title}}{{/link-to}}</li>
        {{/each}}
        </ul>
      </div>
    </div>
  </script>
</body>
</html>

```
Below is the javascript that does the magic

```javascript

var App = Ember.Application.create({
  LOG_TRANSITIONS: true
});
App.Router.map(function() {
  this.route('credits', { path: '/thanks' });
  this.resource('products', function() {
    this.resource('product', { path: '/:product_id' });
  });
  this.resource('contacts', function() {
    this.resource('contact', { path: '/:contact_id' });
  });
});

App.IndexController = Ember.Controller.extend({
  productsCount: 6,
  logo: 'images/logo-small.png',
  time: function() {
    return (new Date()).toDateString();
  }.property()
});
App.ContactsIndexController = Ember.Controller.extend({
  contactName: 'Anostagia',
  avatar: 'images/avatar.png',
  open: function() {
    return ((new Date()).getDay() === 0) ? "Closed" : "Open";
  }.property()
});

App.ProductsRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('product');
  }
});
App.ContactsRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('contact');
  }
});

App.ApplicationAdapter = DS.FixtureAdapter.extend();
App.Product = DS.Model.extend({
  title: DS.attr('string'),
  price: DS.attr('number'),
  description: DS.attr('string'),
  isOnSale: DS.attr('boolean'),
  image: DS.attr('string'),
  reviews: DS.hasMany('review', { async: true }),
  crafter: DS.belongsTo('contact', { async: true })
});

App.Product.FIXTURES = [
 {  id: 1,
    title: 'Flint',
    price: 99,
    description: 'Flint is a hard, sedimentary cryptocrystalline form of the mineral quartz, categorized as a variety of chert.',
    isOnSale: true,
    image: 'images/products/flint.png',
    reviews: [100,101],
    crafter: 200
  },
  {
    id: 2,
    title: 'Kindling',
    price: 249,
    description: 'Easily combustible small sticks or twigs used for starting a fire.',
    isOnSale: false,
    image: 'images/products/kindling.png',
    reviews: [],
    crafter: 201
  },
  {
    id: 3,
    title: 'Matches',
    price: 499,
    description: 'One end is coated with a material that can be ignited by frictional heat generated by striking the match against a suitable surface.',
    isOnSale: true,
    reviews: [103],
    image: 'images/products/matches.png',
    crafter: 201
  },
  {
    id: 4,
    title: 'Bow Drill',
    price: 999,
    description: 'The bow drill is an ancient tool. While it was usually used to make fire, it was also used for primitive woodworking and dentistry.',
    isOnSale: false,
    reviews: [104],
    image: 'images/products/bow-drill.png',
    crafter: 200
  },
  {
    id: 5,
    title: 'Tinder',
    price: 499,
    description: 'Tinder is easily combustible material used to ignite fires by rudimentary methods.',
    isOnSale: true,
    reviews: [],
    image: 'images/products/tinder.png',
    crafter: 201
  },
  {
    id: 6,
    title: 'Birch Bark Shaving',
    price: 999,
    description: 'Fresh and easily combustable',
    isOnSale: true,
    reviews: [],
    image: 'images/products/birch.png',
    crafter: 200
  }
];

App.Contact = DS.Model.extend({
  name: DS.attr('string'),
  about: DS.attr('string'),
  avatar: DS.attr('string'),
  products: DS.hasMany('product', { async: true })
});
App.Contact.FIXTURES = [
  {
    id: 200,
    name: 'Giamia',
    about: 'Although Giamia came from a humble spark of lightning, he quickly grew to be a great craftsman, providing all the warming instruments needed by those close to him.',
    avatar: 'images/contacts/giamia.png',
    products: [1]
  },
  {
    id: 201,
    name: 'Anostagia',
    about: 'Knowing there was a need for it, Anostagia drew on her experience and spearheaded the Flint & Flame storefront. In addition to coding the site, she also creates a few products available in the store.',
    avatar: 'images/contacts/anostagia.png',
    products: [2]
  }
];

App.Review = DS.Model.extend({
  text: DS.attr('string'),
  reviewedAt: DS.attr('date'),
  product: DS.belongsTo('product')
});
App.Review.FIXTURES = [
  {
    id: 100,
    text: "Started a fire in no time!"
  },
  {
    id: 101,
    text: "Not the brightest flame, but warm!"
  }
];

```
Soon, there will be some pen and comments to explian the code.





