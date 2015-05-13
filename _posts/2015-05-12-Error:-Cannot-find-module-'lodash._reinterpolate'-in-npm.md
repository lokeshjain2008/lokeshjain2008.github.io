---
layout: post
date: "Tue May 12 15:08:16 2015"
comments: true
title: "Error: Cannot find module 'lodash. reinterpolate' in npm"
---

I was working with `angular` project and was using `node` for the server and package dependies.
After doint some package installing.

`npm install` was installing all the dependies.

so, i removed my node_modules folder

```
 rm -rf node_modules
```

did again `npm install` and running gulp task gave me error.

```
[14:50:36] 'build:javascripts:templates' errored after 698 ms
[14:50:36] Error: Cannot find module 'lodash._reinterpolate'
    at Function.Module._resolveFilename (module.js:338:15)
    at Function.Module._load (module.js:280:25)
    at Module.require (module.js:364:17)
    at require (module.js:380:17)
    at Object.<anonymous> (/Users/Lokesh/Documents/

```

What to do? Tried everything and then
found the solution.

```bash
{sudo -H} npm i -g npm
npm i --save lodash._reinterpolate

```
Both solved my problem.

#### npm-schrinkwrap.json file ???

For the production we use `npm-schrinkwrap.json` file. this holds all the dependies for the project its just like `package.json` lock.

Note: when we do

```
npm install <package> --save  #will not change the `schrinkwrap`
//run
npm schrinkwrap
//now the npm-schirnkwrap will be updated

```







