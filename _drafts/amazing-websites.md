List of amazing websites for developers
-[cloud 9](c9.io)
-[terminal](https://www.terminal.com/)
-[koding](https://koding.com/)
-[gitter](https://gitter.im)
-[ElasticBox](https://elasticbox.com/)
-[ChefIO](https://www.chef.io/) See video how it works. That is enough for convince me to use it.


# below is the shit bro...
---
layout: post
date: %Q{Mon Mar  2 11:44:54 2015}
comments: true
title: personal project talk
---
 
 # for the PT ..


 User flow

 for the budget will be created for the every entry in the system for the user.

BUDGET----
 user has_many budgets 
 budget has_many budget_product_families when we first select them 

 after adding it will got the 
budget has_many budget_products


	every budget  has_one bussiness_category and bussiness_subcategory


After the 'recommendation <tab>' 
There will be request to the sql query to get the data(pricing).
After the calculation
>snapshot will be created....
>snapshot : pdf_templates : public_urls
>snapshot create pdf.


Scenerio : select 
only one product 
'totalTrack' : 

budget.budget_product_families : has connection to product_family

so,
bp = budget.budget_product_families
bp.product_family :: "Shows the `totalTrack`".
  | there is funnel segement where is listed on the page is :::> annotation_funnel_segment : column
  annotation_funnel_segment: "Contact & Choose",
  | There is budget_type is also :  annotation_budget_type: "Service"

  pf  = bp.product_family : has many_product

  for the totalTrack it has 3 products.

  Yes!! each product_family has many products in the products table.
  Fro TitleTrack There are 3 products...
  this is has all the information about the min_budget/name /display content and all
  





---PILOTS
this is used for A/B testing : all the overides will happen here.


