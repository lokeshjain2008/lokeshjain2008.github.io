---
layout: post
date: "Thu Jul  9 10:41:04 2015"
comments: true
title: "angular animation 1.4 with ui router stop working wierd behaviour"
---

 Angular with Angular-animation is great. We started our project including
 `angualr#1.2.16`, `angualr-animate#1.2.16` and `ui-router`. We had some animation
 in our app using `angular-animate` module.

 Currently, our team decided to upgrade `angular` version from `1.2 to 1.4.1`.
 The up-gradation was smooth every thing was working as expected but animations on the page.

 After hours of debugging we found that `angualr-animate` was not recognizing any animation.
 We found that magic classes like `ng-hide-active, ng-animate, ...` were missing. That is angular animation
is doing nothing. see the pen.

<p data-height="268" data-theme-id="0" data-slug-hash="NqMNeZ" data-default-tab="result" data-user="lokeshjain2008" class='codepen'>See the Pen <a href='http://codepen.io/lokeshjain2008/pen/NqMNeZ/'>NqMNeZ</a> by lokesh kumar jain (<a href='http://codepen.io/lokeshjain2008'>@lokeshjain2008</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>


Working `pen`. The solution was to make move `Ui-view` from body tag.

```html
<body Ui-view>
    <div ></div>
</body>
```

to div tag.


```html
<body>
    <div ui-view></div>
  </body>

```



<p data-height="268" data-theme-id="0" data-slug-hash="BNxKGM" data-default-tab="result" data-user="lokeshjain2008" class='codepen'>See the Pen <a href='http://codepen.io/lokeshjain2008/pen/BNxKGM/'>BNxKGM</a> by lokesh kumar jain (<a href='http://codepen.io/lokeshjain2008'>@lokeshjain2008</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
