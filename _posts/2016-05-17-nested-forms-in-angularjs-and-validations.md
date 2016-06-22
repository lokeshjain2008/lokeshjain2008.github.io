
---
layout: post
date: Tue May 17 13:22:59 2016
comments: true
title: nested forms in angularjs and validations
---
 _posts/2016-05-17-nested-forms-in-angularjs-and-validations.md// making cc / dd / address forms submitted using '$submitted = true'
        // we can't use $setSubmitted(true) on cc / dd / address forms as the
        // event bubbles through and set ng-submitted on outer / payment form.
        