---
layout: post
date: "Fri Jul 24 15:08:46 2015"
comments: true
title: "Promise done right way"
---

<div class="col-md-offset-1 col-md-10">


<div class="post">
 

     <p>Fellow JavaScripters, it's time to admit it: we have a problem with promises.</p>

<p>No, not with promises themselves. Promises, as defined by the <a href="https://promisesaplus.com/">A+ spec</a>, are awesome.</p>

<p>The big problem, which has revealed itself to me over the course of the past year, as I've watched numerous programmers struggle with the PouchDB API and other promise-heavy APIs, is this:</p>

<p>Many of us are using promises <em>without really understanding them</em>.</p>

<p>If you find that hard to believe, consider this puzzle <a href="https://twitter.com/nolanlawson/status/578948854411878400">I recently posted to Twitter</a>:</p>

<p><strong>Q: What is the difference between these four promises?</strong></p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">doSomethingElse</span><span class="p">();</span>
<span class="p">});</span>

<span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="nx">doSomethingElse</span><span class="p">();</span>
<span class="p">});</span>

<span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="nx">doSomethingElse</span><span class="p">());</span>

<span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="nx">doSomethingElse</span><span class="p">);</span>
</code></pre></div>
<p>If you know the answer, then congratulations: you're a promises ninja. You have my permission to stop reading this blog post.</p>

<p>For the other 99.99% of you, you're in good company. Nobody who responded to my tweet could solve it, and I myself was surprised by the answer to #3. Yes, even though I wrote the quiz!</p>

<p>The answers are at the end of this post, but first, I'd like to explore why promises are so tricky in the first place, and why so many of us – novices and experts alike – get tripped up by them. I'm also going to offer what I consider to be the singular insight, the <em>one weird trick</em>, that makes promises a cinch to understand. And yes, I really do believe they're not so hard after that!</p>

<p>But to start with, let's challenge some common assumptions about promises.</p>

<h2>Wherefore promises?</h2>

<p>If you read the literature on promises, you'll often find references to <a href="https://medium.com/@wavded/managing-node-js-callback-hell-1fe03ba8baf">the pyramid of doom</a>, with some horrible callback-y code that steadily stretches toward the right side of the screen.</p>

<p>Promises do indeed solve this problem, but it's about more than just indentation. As explained in the brilliant talk <a href="http://youtu.be/hf1T_AONQJU">"Redemption from Callback Hell"</a>, the real problem with callbacks it that they deprive us of keywords like <code>return</code> and <code>throw</code>. Instead, our program's entire flow is based on <em>side effects</em>: one function incidentally calling another one.</p>

<p>And in fact, callbacks do something even more sinister: they deprive us of the <em>stack</em>, which is something we usually take for granted in programming languages. Writing code without a stack is a lot like driving a car without a brake pedal: you don't realize how badly you need it, until you reach for it and it's not there.</p>

<p>The whole point of promises is to give us back the language fundamentals we lost when we went async: <code>return</code>, <code>throw</code>, and the stack. But you have to know how to use promises correctly in order to take advantage of them.</p>

<h2>Rookie mistakes</h2>

<p>Some people try to explain promises <a href="http://andyshora.com/promises-angularjs-explained-as-cartoon.html">as a cartoon</a>, or in a very noun-oriented way: "Oh, it's this thing you can pass around that represents an asynchronous value."</p>

<p>I don't find such explanations very helpful. To me, promises are all about code structure and flow. So I think it's better to just go over some common mistakes and show how to fix them. I call these "rookie mistakes" in the sense of, "you're a rookie now, kid, but you'll be a pro soon."</p>

<p>Quick digression: "promises" mean a lot of different things to different people, but for the purposes of this article, I'm only going to talk about <a href="https://promisesaplus.com/">the official spec</a>, as exposed in modern browsers as <code>window.Promise</code>. Not all browsers have <code>window.Promise</code> though, so for a good polyfill, check out the cheekily-named <a href="https://github.com/calvinmetcalf/lie">Lie</a>, which is about the smallest spec-compliant library out there.</p>

<h2>Rookie mistake #1: the promisey pyramid of doom</h2>

<p>Looking at how people use PouchDB, which has a largely promise-based API, I see a lot of poor promise patterns. The most common bad practice is this one:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">remotedb</span><span class="p">.</span><span class="nx">allDocs</span><span class="p">({</span>
 <span class="nx">include_docs</span><span class="o">:</span> <span class="kc">true</span><span class="p">,</span>
 <span class="nx">attachments</span><span class="o">:</span> <span class="kc">true</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="kd">var</span> <span class="nx">docs</span> <span class="o">=</span> <span class="nx">result</span><span class="p">.</span><span class="nx">rows</span><span class="p">;</span>
 <span class="nx">docs</span><span class="p">.</span><span class="nx">forEach</span><span class="p">(</span><span class="kd">function</span><span class="p">(</span><span class="nx">element</span><span class="p">)</span> <span class="p">{</span>
   <span class="nx">localdb</span><span class="p">.</span><span class="nx">put</span><span class="p">(</span><span class="nx">element</span><span class="p">.</span><span class="nx">doc</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span><span class="p">(</span><span class="nx">response</span><span class="p">)</span> <span class="p">{</span>
     <span class="nx">alert</span><span class="p">(</span><span class="s2">"Pulled doc with id "</span> <span class="o">+</span> <span class="nx">element</span><span class="p">.</span><span class="nx">doc</span><span class="p">.</span><span class="nx">_id</span> <span class="o">+</span> <span class="s2">" and added to local db."</span><span class="p">);</span>
   <span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
     <span class="k">if</span> <span class="p">(</span><span class="nx">err</span><span class="p">.</span><span class="nx">status</span> <span class="o">==</span> <span class="mi">409</span><span class="p">)</span> <span class="p">{</span>
       <span class="nx">localdb</span><span class="p">.</span><span class="nx">get</span><span class="p">(</span><span class="nx">element</span><span class="p">.</span><span class="nx">doc</span><span class="p">.</span><span class="nx">_id</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resp</span><span class="p">)</span> <span class="p">{</span>
         <span class="nx">localdb</span><span class="p">.</span><span class="nx">remove</span><span class="p">(</span><span class="nx">resp</span><span class="p">.</span><span class="nx">_id</span><span class="p">,</span> <span class="nx">resp</span><span class="p">.</span><span class="nx">_rev</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resp</span><span class="p">)</span> <span class="p">{</span>
<span class="c1">// et cetera...</span>
</code></pre></div>
<p>Yes, it turns out you can use promises as if they were callbacks, and yes, it's a lot like using a power sander to file your nails, but you can do it.</p>

<p>And if you think this sort of mistake is only limited to absolute beginners, you'll be surprised to learn that I actually took <a href="https://github.com/blackberry/BB10-WebWorks-Community-Samples/blob/d6ee75fe23a10d2d3a036013b6b1a0c07a542099/pdbtest/www/js/index.js">the above code</a> from <a href="http://devblog.blackberry.com/2015/05/connecting-to-couchbase-with-pouchdb/">the official BlackBerry developer blog</a>! Old callback habits die hard. (And to the developer: sorry to pick on you, but your example is instructive.)</p>

<p>A better style is this one:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">remotedb</span><span class="p">.</span><span class="nx">allDocs</span><span class="p">(...).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resultOfAllDocs</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">localdb</span><span class="p">.</span><span class="nx">put</span><span class="p">(...);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resultOfPut</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">localdb</span><span class="p">.</span><span class="nx">get</span><span class="p">(...);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resultOfGet</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">localdb</span><span class="p">.</span><span class="nx">put</span><span class="p">(...);</span>
<span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">console</span><span class="p">.</span><span class="nx">log</span><span class="p">(</span><span class="nx">err</span><span class="p">);</span>
<span class="p">});</span>
</code></pre></div>
<p>This is called <em>composing promises</em>, and it's one of the great superpowers of promises. Each function will only be called when the previous promise has resolved, and it'll be called with that promise's output. More on that later.</p>

<h2>Rookie mistake #2: WTF, how do I use <code>forEach()</code> with promises?</h2>

<p>This is where most people's understanding of promises starts to break down. As soon as they reach for their familiar <code>forEach()</code> loop (or <code>for</code> loop, or <code>while</code> loop), they have no idea how to make it work with promises. So they write something like this:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="c1">// I want to remove() all docs</span>
<span class="nx">db</span><span class="p">.</span><span class="nx">allDocs</span><span class="p">({</span><span class="nx">include_docs</span><span class="o">:</span> <span class="kc">true</span><span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">result</span><span class="p">.</span><span class="nx">rows</span><span class="p">.</span><span class="nx">forEach</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">row</span><span class="p">)</span> <span class="p">{</span>
   <span class="nx">db</span><span class="p">.</span><span class="nx">remove</span><span class="p">(</span><span class="nx">row</span><span class="p">.</span><span class="nx">doc</span><span class="p">);</span>  
 <span class="p">});</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="c1">// I naively believe all docs have been removed() now!</span>
<span class="p">});</span>
</code></pre></div>
<p>What's the problem with this code? The problem is that the first function is actually returning <code>undefined</code>, meaning that the second function isn't waiting for <code>db.remove()</code> to be called on all the documents. In fact, it isn't waiting on anything, and can execute when any number of docs have been removed!</p>

<p>This is an especially insidious bug, because you may not notice anything is wrong, assuming PouchDB removes those documents fast enough for your UI to be updated. The bug may only pop up in the odd race conditions, or in certain browsers, at which point it will be nearly impossible to debug.</p>

<p>The TLDR of all this is that <code>forEach()</code>/<code>for</code>/<code>while</code> are not the constructs you're looking for. You want <code>Promise.all()</code>:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">db</span><span class="p">.</span><span class="nx">allDocs</span><span class="p">({</span><span class="nx">include_docs</span><span class="o">:</span> <span class="kc">true</span><span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">Promise</span><span class="p">.</span><span class="nx">all</span><span class="p">(</span><span class="nx">result</span><span class="p">.</span><span class="nx">rows</span><span class="p">.</span><span class="nx">map</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">row</span><span class="p">)</span> <span class="p">{</span>
   <span class="k">return</span> <span class="nx">db</span><span class="p">.</span><span class="nx">remove</span><span class="p">(</span><span class="nx">row</span><span class="p">.</span><span class="nx">doc</span><span class="p">);</span>
 <span class="p">}));</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">arrayOfResults</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// All docs have really been removed() now!</span>
<span class="p">});</span>
</code></pre></div>
<p>What's going on here? Basically <code>Promise.all()</code> takes an <em>array of promises</em> as input, and then it gives you another promise that only resolves when every one of those other promises has resolved. It is the asynchronous equivalent of a for-loop.</p>

<p><code>Promise.all()</code> also passes an array of results to the next function, which can get very useful, for instance if you are trying to <code>get()</code> multiple things from PouchDB. The <code>all()</code> promise is also rejected if <em>any one of its sub-promises are rejected</em>, which is even more useful.</p>

<h2>Rookie mistake #3: forgetting to add .catch()</h2>

<p>This is another common mistake. Blissfully confident that their promises could never possibly throw an error, many developers forget to add a <code>.catch()</code> anywhere in their code. Unfortunately this means that any thrown errors <em>will be swallowed</em>, and you won't even see them in your console. This can be a real pain to debug.</p>

<p>To avoid this nasty scenario, I've gotten into the habit of simply adding the following code to my promise chains:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">anotherPromise</span><span class="p">();</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">yetAnotherPromise</span><span class="p">();</span>
<span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="nx">console</span><span class="p">.</span><span class="nx">log</span><span class="p">.</span><span class="nx">bind</span><span class="p">(</span><span class="nx">console</span><span class="p">));</span> <span class="c1">// &lt;-- this is badass</span>
</code></pre></div>
<p>Even if you never expect an error, it's always prudent to add a <code>catch()</code>. It'll make your life easier, if your assumptions ever turn out to be wrong.</p>

<h2>Rookie mistake #4: using "deferred"</h2>

<p>This is a mistake I see <a href="http://gonehybrid.com/how-to-use-pouchdb-sqlite-for-local-storage-in-your-ionic-app/">all the time</a>, and I'm reluctant to even repeat it here, for fear that, like Beetlejuice, merely invoking its name will summon more instances of it.</p>

<p>In short, promises have a long and storied history, and it took the JavaScript community a long time to get them right. In the early days, jQuery and Angular were using this "deferred" pattern all over the place, which has now been replaced with the ES6 Promise spec, as implemented by "good" libraries like Q, When, RSVP, Bluebird, Lie, and others.</p>

<p>So if you are writing that word in your code (I won't repeat it a third time!), you are doing something wrong. Here's how to avoid it.</p>

<p>First off, most promise libraries give you a way to "import" promises from third-party libraries. For instance, Angular's <code>$q</code> module allows you to wrap non-<code>$q</code> promises using <code>$q.when()</code>. So Angular users can wrap PouchDB promises this way:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">$q</span><span class="p">.</span><span class="nx">when</span><span class="p">(</span><span class="nx">db</span><span class="p">.</span><span class="nx">put</span><span class="p">(</span><span class="nx">doc</span><span class="p">)).</span><span class="nx">then</span><span class="p">(</span><span class="cm">/* ... */</span><span class="p">);</span> <span class="c1">// &lt;-- this is all the code you need</span>
</code></pre></div>
<p>Another strategy is to use the <a href="https://blog.domenic.me/the-revealing-constructor-pattern/">revealing constructor pattern</a>, which is useful for wrapping non-promise APIs. For instance, to wrap a callback-based API like Node's <code>fs.readFile()</code>, you can simply do:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="k">new</span> <span class="nx">Promise</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resolve</span><span class="p">,</span> <span class="nx">reject</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">fs</span><span class="p">.</span><span class="nx">readFile</span><span class="p">(</span><span class="s1">'myfile.txt'</span><span class="p">,</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">,</span> <span class="nx">file</span><span class="p">)</span> <span class="p">{</span>
   <span class="k">if</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
     <span class="k">return</span> <span class="nx">reject</span><span class="p">(</span><span class="nx">err</span><span class="p">);</span>
   <span class="p">}</span>
   <span class="nx">resolve</span><span class="p">(</span><span class="nx">file</span><span class="p">);</span>
 <span class="p">});</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="cm">/* ... */</span><span class="p">)</span>
</code></pre></div>
<p>Done! We have defeated the dreaded def... Aha, caught myself. :)</p>

<div class="alert alert-info">


<div class="alert-text">


<p>For more about why this is an anti-pattern, check out <a href="https://github.com/petkaantonov/bluebird/wiki/Promise-anti-patterns#the-deferred-anti-pattern">the Bluebird wiki page on promise anti-patterns</a>.</p>

</div></div>

<h2>Rookie mistake #5: using side effects instead of returning</h2>

<p>What's wrong with this code?</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="nx">someOtherPromise</span><span class="p">();</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="c1">// Gee, I hope someOtherPromise() has resolved!</span>
 <span class="c1">// Spoiler alert: it hasn't.</span>
<span class="p">});</span>
</code></pre></div>
<p>Okay, this is a good point to talk about everything you ever need to know about promises.</p>

<p>Seriously, this is the <em>one weird trick</em> that, once you understand it, will prevent all of the errors I've been talking about. You ready?</p>

<p>As I said before, the magic of promises is that they give us back our precious <code>return</code> and <code>throw</code>. But what does this actually look like in practice?</p>

<p>Every promise gives you a <code>then()</code> method (or <code>catch()</code>, which is just sugar for <code>then(null, ...)</code>). Here we are inside of a <code>then()</code> function:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="c1">// I'm inside a then() function!</span>
<span class="p">});</span>
</code></pre></div>
<p>What can we do here? There are three things:</p>

<ol>
<li><code>return</code> another promise</li>
<li><code>return</code> a synchronous value (or <code>undefined</code>)</li>
<li><code>throw</code> a synchronous error</li>
</ol>

<p>That's it. Once you understand this trick, you understand promises. So let's go through each point one at a time.</p>

<h4>1. Return another promise</h4>

<p>This is a common pattern you see in the promise literature, as in the "composing promises" example above:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// I got a user account!</span>
<span class="p">});</span>
</code></pre></div>
<p>Notice that I'm <code>return</code>ing the second promise – that <code>return</code> is crucial. If I didn't say <code>return</code>, then the <code>getUserAccountById()</code> would actually be a <em>side effect</em>, and the next function would receive <code>undefined</code> instead of the <code>userAccount</code>.</p>

<h4>2. Return a synchronous value (or undefined)</h4>

<p>Returning <code>undefined</code> is often a mistake, but returning a synchronous value is actually an awesome way to convert synchronous code into promisey code. For instance, let's say we have an in-memory cache of users. We can do:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">if</span> <span class="p">(</span><span class="nx">inMemoryCache</span><span class="p">[</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">])</span> <span class="p">{</span>
   <span class="k">return</span> <span class="nx">inMemoryCache</span><span class="p">[</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">];</span>    <span class="c1">// returning a synchronous value!</span>
 <span class="p">}</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span> <span class="c1">// returning a promise!</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// I got a user account!</span>
<span class="p">});</span>
</code></pre></div>
<p>Isn't that awesome? The second function doesn't care whether the <code>userAccount</code> was fetched synchronously or asynchronously, and the first function is free to return either a synchronous or asynchronous value.</p>

<p>Unfortunately, there's the inconvenient fact that non-returning functions in JavaScript technically return <code>undefined</code>, which means it's easy to accidentally introduce side effects when you meant to return something.</p>

<p>For this reason, I make it a personal habit to <em>always return or throw</em> from inside a <code>then()</code> function. I'd recommend you do the same.</p>

<h4>3. Throw a synchronous error</h4>

<p>Speaking of <code>throw</code>, this is where promises can get even more awesome. Let's say we want to <code>throw</code> a synchronous error in case the user is logged out. It's quite easy:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">if</span> <span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">isLoggedOut</span><span class="p">())</span> <span class="p">{</span>
   <span class="k">throw</span> <span class="k">new</span> <span class="nb">Error</span><span class="p">(</span><span class="s1">'user logged out!'</span><span class="p">);</span> <span class="c1">// throwing a synchronous error!</span>
 <span class="p">}</span>
 <span class="k">if</span> <span class="p">(</span><span class="nx">inMemoryCache</span><span class="p">[</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">])</span> <span class="p">{</span>
   <span class="k">return</span> <span class="nx">inMemoryCache</span><span class="p">[</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">];</span>       <span class="c1">// returning a synchronous value!</span>
 <span class="p">}</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span>    <span class="c1">// returning a promise!</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// I got a user account!</span>
<span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// Boo, I got an error!</span>
<span class="p">});</span>
</code></pre></div>
<p>Our <code>catch()</code> will receive a synchronous error if the user is logged out, and it will receive an asynchronous error if <em>any of the promises are rejected</em>. Again, the function doesn't care whether the error it gets is synchronous or asynchronous.</p>

<p>This is especially useful because it can help identify coding errors during development. For instance, if at any point inside of a <code>then()</code> function, we do a <code>JSON.parse()</code>, it might throw a synchronous error if the JSON is invalid. With callbacks, that error would get swallowed, but with promises, we can simply handle it inside our <code>catch()</code> function.</p>

<h2>Advanced mistakes</h2>

<p>Okay, now that you've learned the single trick that makes promises dead-easy, let's talk about the edge cases. Because of course, there are always edge cases.</p>

<p>These mistakes I'd classify as "advanced," because I've only seen them made by programmers who are already fairly adept with promises. But we're going to need to discuss them, if we want to be able to solve the puzzle I posed at the beginning of this post.</p>

<h2>Advanced mistake #1: not knowing about <code>Promise.resolve()</code></h2>

<p>As I showed above, promises are very useful for wrapping synchronous code as asynchronous code. However, if you find yourself typing this a lot:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="k">new</span> <span class="nx">Promise</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">resolve</span><span class="p">,</span> <span class="nx">reject</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">resolve</span><span class="p">(</span><span class="nx">someSynchronousValue</span><span class="p">);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="cm">/* ... */</span><span class="p">);</span>
</code></pre></div>
<p>You can express this more succinctly using <code>Promise.resolve()</code>:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="nx">someSynchronousValue</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="cm">/* ... */</span><span class="p">);</span>
</code></pre></div>
<p>This is also incredibly useful for catching any synchronous errors. It's so useful, that I've gotten in the habit of beginning nearly all of my promise-returning API methods like this:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">function</span> <span class="nx">somePromiseAPI</span><span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
   <span class="nx">doSomethingThatMayThrow</span><span class="p">();</span>
   <span class="k">return</span> <span class="s1">'foo'</span><span class="p">;</span>
 <span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="cm">/* ... */</span><span class="p">);</span>
<span class="p">}</span>
</code></pre></div>
<p>Just remember: any code that might <code>throw</code> synchronously is a good candidate for a nearly-impossible-to-debug swallowed error somewhere down the line. But if you wrap everything in <code>Promise.resolve()</code>, then you can always be sure to <code>catch()</code> it later.</p>

<p>Similarly, there is a <code>Promise.reject()</code> that you can use to return a promise that is immediately rejected:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">Promise</span><span class="p">.</span><span class="nx">reject</span><span class="p">(</span><span class="k">new</span> <span class="nb">Error</span><span class="p">(</span><span class="s1">'some awful error'</span><span class="p">));</span>
</code></pre></div>
<h2>Advanced mistake #2: <code>catch()</code> isn't exactly like <code>then(null, ...)</code></h2>

<p>I said above that <code>catch()</code> is just sugar. So these two snippets are equivalent:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// handle error</span>
<span class="p">});</span>

<span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kc">null</span><span class="p">,</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// handle error</span>
<span class="p">});</span>
</code></pre></div>
<p>However, that doesn't mean that the following two snippets are equivalent:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">someOtherPromise</span><span class="p">();</span>
<span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// handle error</span>
<span class="p">});</span>

<span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">someOtherPromise</span><span class="p">();</span>
<span class="p">},</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// handle error</span>
<span class="p">});</span>
</code></pre></div>
<p>If you're wondering why they're not equivalent, consider what happens if the first function throws an error:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">throw</span> <span class="k">new</span> <span class="nb">Error</span><span class="p">(</span><span class="s1">'oh noes'</span><span class="p">);</span>
<span class="p">}).</span><span class="k">catch</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// I caught your error! :)</span>
<span class="p">});</span>

<span class="nx">somePromise</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">throw</span> <span class="k">new</span> <span class="nb">Error</span><span class="p">(</span><span class="s1">'oh noes'</span><span class="p">);</span>
<span class="p">},</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// I didn't catch your error! :(</span>
<span class="p">});</span>
</code></pre></div>
<p>As it turns out, when you use the <code>then(resolveHandler, rejectHandler)</code> format, the <code>rejectHandler</code> <em>won't actually catch an error</em> if it's thrown by the <code>resolveHandler</code> itself.</p>

<p>For this reason, I've made it a personal habit to never use the second argument to <code>then()</code>, and to always prefer <code>catch()</code>. The exception is when I'm writing asynchronous <a href="http://mochajs.org/">Mocha</a> tests, where I might write a test to ensure that an error is thrown:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">it</span><span class="p">(</span><span class="s1">'should throw an error'</span><span class="p">,</span> <span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">doSomethingThatThrows</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
   <span class="k">throw</span> <span class="k">new</span> <span class="nb">Error</span><span class="p">(</span><span class="s1">'I expected an error!'</span><span class="p">);</span>
 <span class="p">},</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">err</span><span class="p">)</span> <span class="p">{</span>
   <span class="nx">should</span><span class="p">.</span><span class="nx">exist</span><span class="p">(</span><span class="nx">err</span><span class="p">);</span>
 <span class="p">});</span>
<span class="p">});</span>
</code></pre></div>
<p>Speaking of which, <a href="http://mochajs.org/">Mocha</a> and <a href="http://chaijs.com/">Chai</a> are a lovely combination for testing promise APIs. The <a href="https://github.com/pouchdb/plugin-seed">pouchdb-plugin-seed</a> project has <a href="https://github.com/pouchdb/plugin-seed/blob/master/test/test.js">some sample tests</a> that can get you started.</p>

<h2>Advanced mistake #3: promises vs promise factories</h2>

<p>Let's say you want to execute a series of promises one after the other, in a sequence. That is, you want something like <code>Promise.all()</code>, but which doesn't execute the promises in parallel.</p>

<p>You might naïvely write something like this:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">function</span> <span class="nx">executeSequentially</span><span class="p">(</span><span class="nx">promises</span><span class="p">)</span> <span class="p">{</span>
 <span class="kd">var</span> <span class="nx">result</span> <span class="o">=</span> <span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">();</span>
 <span class="nx">promises</span><span class="p">.</span><span class="nx">forEach</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">promise</span><span class="p">)</span> <span class="p">{</span>
   <span class="nx">result</span> <span class="o">=</span> <span class="nx">result</span><span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">promise</span><span class="p">);</span>
 <span class="p">});</span>
 <span class="k">return</span> <span class="nx">result</span><span class="p">;</span>
<span class="p">}</span>
</code></pre></div>
<p>Unfortunately, this will not work the way you intended. The promises you pass in to <code>executeSequentially()</code> will <em>still</em> execute in parallel.</p>

<p>The reason this happens is that you don't want to operate over an array of promises at all. Per the promise spec, as soon as a promise is created, it begins executing. So what you really want is an array of <em>promise factories</em>:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">function</span> <span class="nx">executeSequentially</span><span class="p">(</span><span class="nx">promiseFactories</span><span class="p">)</span> <span class="p">{</span>
 <span class="kd">var</span> <span class="nx">result</span> <span class="o">=</span> <span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">();</span>
 <span class="nx">promiseFactories</span><span class="p">.</span><span class="nx">forEach</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">promiseFactory</span><span class="p">)</span> <span class="p">{</span>
   <span class="nx">result</span> <span class="o">=</span> <span class="nx">result</span><span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">promiseFactory</span><span class="p">);</span>
 <span class="p">});</span>
 <span class="k">return</span> <span class="nx">result</span><span class="p">;</span>
<span class="p">}</span>
</code></pre></div>
<p>I know what you're thinking: "Who the hell is this Java programmer, and why is he talking about factories?" A promise factory is very simple, though – it's just a function that returns a promise:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">function</span> <span class="nx">myPromiseFactory</span><span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">somethingThatCreatesAPromise</span><span class="p">();</span>
<span class="p">}</span>
</code></pre></div>
<p>Why does this work? It works because a promise factory doesn't create the promise until it's asked to. It works the same way as a <code>then</code> function – in fact, it's the same thing!</p>

<p>If you look at the <code>executeSequentially()</code> function above, and then imagine <code>myPromiseFactory</code> being substituted inside of <code>result.then(...)</code>, then hopefully a light bulb will click in your brain. At that moment, you will have achieved promise enlightenment.</p>

<h2>Advanced mistake #4: okay, what if I want the result of two promises?</h2>

<p>Often times, one promise will depend on another, but we'll want the output of both promises. For instance:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// dangit, I need the "user" object too!</span>
<span class="p">});</span>
</code></pre></div>
<p>Wanting to be good JavaScript developers and avoid the pyramid of doom, we might just store the <code>user</code> object in a higher-scoped variable:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">var</span> <span class="nx">user</span><span class="p">;</span>
<span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">user</span> <span class="o">=</span> <span class="nx">result</span><span class="p">;</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="c1">// okay, I have both the "user" and the "userAccount"</span>
<span class="p">});</span>
</code></pre></div>
<p>This works, but I personally find it a bit kludgey. My recommended strategy: just let go of your preconceptions and embrace the pyramid:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
   <span class="c1">// okay, I have both the "user" and the "userAccount"</span>
 <span class="p">});</span>
<span class="p">});</span>
</code></pre></div>
<p>...at least, temporarily. If the indentation ever becomes an issue, then you can do what JavaScript developers have been doing since time immemorial, and extract the function into a named function:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="kd">function</span> <span class="nx">onGetUserAndUserAccount</span><span class="p">(</span><span class="nx">user</span><span class="p">,</span> <span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">doSomething</span><span class="p">(</span><span class="nx">user</span><span class="p">,</span> <span class="nx">userAccount</span><span class="p">);</span>
<span class="p">}</span>

<span class="kd">function</span> <span class="nx">onGetUser</span><span class="p">(</span><span class="nx">user</span><span class="p">)</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">getUserAccountById</span><span class="p">(</span><span class="nx">user</span><span class="p">.</span><span class="nx">id</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">userAccount</span><span class="p">)</span> <span class="p">{</span>
   <span class="k">return</span> <span class="nx">onGetUserAndUserAccount</span><span class="p">(</span><span class="nx">user</span><span class="p">,</span> <span class="nx">userAccount</span><span class="p">);</span>
 <span class="p">});</span>
<span class="p">}</span>

<span class="nx">getUserByName</span><span class="p">(</span><span class="s1">'nolan'</span><span class="p">)</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">onGetUser</span><span class="p">)</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="c1">// at this point, doSomething() is done, and we are back to indentation 0</span>
<span class="p">});</span>
</code></pre></div>
<p>As your promise code starts to get more complex, you may find yourself extracting more and more functions into named functions. I find this leads to very aesthetically-pleasing code, which might look like this:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">putYourRightFootIn</span><span class="p">()</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">putYourRightFootOut</span><span class="p">)</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">putYourRightFootIn</span><span class="p">)</span>  
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">shakeItAllAbout</span><span class="p">);</span>
</code></pre></div>
<p>That's what promises are all about.</p>

<h2>Advanced mistake #5: promises fall through</h2>

<p>Finally, this is the mistake I alluded to when I introduced the promise puzzle above. This is a very esoteric use case, and it may never come up in your code, but it certainly surprised me.</p>

<p>What do you think this code prints out?</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="s1">'foo'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="s1">'bar'</span><span class="p">)).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">console</span><span class="p">.</span><span class="nx">log</span><span class="p">(</span><span class="nx">result</span><span class="p">);</span>
<span class="p">});</span>
</code></pre></div>
<p>If you think it prints out <code>bar</code>, you're mistaken. It actually prints out <code>foo</code>!</p>

<p>The reason this happens is because when you pass <code>then()</code> a non-function (such as a promise), it actually interprets it as <code>then(null)</code>, which causes the previous promise's result to fall through. You can test this yourself:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="s1">'foo'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kc">null</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">console</span><span class="p">.</span><span class="nx">log</span><span class="p">(</span><span class="nx">result</span><span class="p">);</span>
<span class="p">});</span>
</code></pre></div>
<p>Add as many <code>then(null)</code>s as you want; it will still print <code>foo</code>.</p>

<p>This actually circles back to the previous point I made about promises vs promise factories. In short, you <em>can</em> pass a promise directly into a <code>then()</code> method, but it won't do what you think it's doing. <code>then()</code> is supposed to take a function, so most likely you meant to do:</p>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="s1">'foo'</span><span class="p">).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">Promise</span><span class="p">.</span><span class="nx">resolve</span><span class="p">(</span><span class="s1">'bar'</span><span class="p">);</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">(</span><span class="nx">result</span><span class="p">)</span> <span class="p">{</span>
 <span class="nx">console</span><span class="p">.</span><span class="nx">log</span><span class="p">(</span><span class="nx">result</span><span class="p">);</span>
<span class="p">});</span>
</code></pre></div>
<p>This will print <code>bar</code>, as we expected.</p>

<p>So just remind yourself: always pass a function into <code>then()</code>!</p>

<h2>Solving the puzzle</h2>

<p>Now that we've learned everything there is to know about promises (or close to it!), we should be able to solve the puzzle I originally posed at the start of this post.</p>

<p>Here is the answer to each one, in graphical format so you can better visualize it:</p>

<h3>Puzzle #1</h3>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="k">return</span> <span class="nx">doSomethingElse</span><span class="p">();</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="nx">finalHandler</span><span class="p">);</span>
</code></pre></div>
<p>Answer:</p>
<div class="highlight"><pre><code class="language-text" data-lang="text">doSomething
|-----------------|
                 doSomethingElse(undefined)
                 |------------------|
                                    finalHandler(resultOfDoSomethingElse)
                                    |------------------|
</code></pre></div>
<h3>Puzzle #2</h3>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
 <span class="nx">doSomethingElse</span><span class="p">();</span>
<span class="p">}).</span><span class="nx">then</span><span class="p">(</span><span class="nx">finalHandler</span><span class="p">);</span>
</code></pre></div>
<p>Answer:</p>
<div class="highlight"><pre><code class="language-text" data-lang="text">doSomething
|-----------------|
                 doSomethingElse(undefined)
                 |------------------|
                 finalHandler(undefined)
                 |------------------|
</code></pre></div>
<h3>Puzzle #3</h3>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="nx">doSomethingElse</span><span class="p">())</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">finalHandler</span><span class="p">);</span>
</code></pre></div>
<p>Answer:</p>
<div class="highlight"><pre><code class="language-text" data-lang="text">doSomething
|-----------------|
doSomethingElse(undefined)
|---------------------------------|
                 finalHandler(resultOfDoSomething)
                 |------------------|
</code></pre></div>
<h3>Puzzle #4</h3>
<div class="highlight"><pre><code class="language-js" data-lang="js"><span class="nx">doSomething</span><span class="p">().</span><span class="nx">then</span><span class="p">(</span><span class="nx">doSomethingElse</span><span class="p">)</span>
 <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">finalHandler</span><span class="p">);</span>
</code></pre></div>
<p>Answer:</p>
<div class="highlight"><pre><code class="language-text" data-lang="text">doSomething
|-----------------|
                 doSomethingElse(resultOfDoSomething)
                 |------------------|
                                    finalHandler(resultOfDoSomethingElse)
                                    |------------------|
</code></pre></div>
<p>If these answers still don't make sense, then I encourage you to re-read the post, or to define the <code>doSomething()</code> and <code>doSomethingElse()</code> methods and try it out yourself in your browser.</p>

<div class="alert alert-info">


<div class="alert-text">


<p><strong>Clarification:</strong> for these examples, I’m assuming that both <code>doSomething()</code> and <code>doSomethingElse()</code> return promises, and that those promises represent something done outside of the JavaScript event loop (e.g. IndexedDB, network, <code>setTimeout</code>), which is why they’re shown as being concurrent when appropriate. Here’s a <a href="http://jsbin.com/tuqukakawo/1/edit?js,console,output">JSBin</a> to demonstrate.</p>

</div></div>

<p>And for more advanced uses of promises, check out my <a href="https://gist.github.com/nolanlawson/6ce81186421d2fa109a4">promise protips cheat sheet</a>.</p>

<h2>Final word about promises</h2>

<p>Promises are great. If you are still using callbacks, I strongly encourage you to switch over to promises. Your code will become smaller, more elegant, and easier to reason about.</p>

<p>And if you don't believe me, here's proof: <a href="https://t.co/hRyc6ENYGC">a refactor of PouchDB's map/reduce module</a> to replace callbacks with promises. The result: 290 insertions, 555 deletions.</p>

<p>Incidentally, the one who wrote that nasty callback code was… me! So this served as my first lesson in the raw power of promises, and I thank the other PouchDB contributors for coaching me along the way.</p>

<p>That being said, promises aren't perfect. It's true that they're better than callbacks, but that's a lot like saying that a punch in the gut is better than a kick in the teeth. Sure, one is preferable to the other, but if you had a choice, you'd probably avoid them both.</p>

<p>While superior to callbacks, promises are still difficult to understand and error-prone, as evidenced by the fact that I felt compelled to write this blog post. Novices and experts alike will frequently mess this stuff up, and really, it's not their fault. The problem is that promises, while similar to the patterns we use in synchronous code, are a decent substitute but not quite the same.</p>

<p>In truth, you shouldn't have to learn a bunch of arcane rules and new APIs to do things that, in the synchronous world, you can do perfectly well with familiar patterns like <code>return</code>, <code>catch</code>, <code>throw</code>, and for-loops. There shouldn't be two parallel systems that you have to keep straight in your head at all times.</p>

<h2>Awaiting async/await</h2>

<p>That's the point I made in <a href="http://pouchdb.com/2015/03/05/taming-the-async-beast-with-es7.html">"Taming the asynchronous beast with ES7"</a>, where I explored the ES7 <code>async</code>/<code>await</code> keywords, and how they integrate promises more deeply into the language. Instead of having to write pseudo-synchronous code (with a fake <code>catch()</code> method that's kinda like <code>catch</code>, but not really), ES7 will allow us to use the real <code>try</code>/<code>catch</code>/<code>return</code> keywords, just like we learned in CS 101.</p>

<p>This is a huge boon to JavaScript as a language. Because in the end, these promise anti-patterns will still keep cropping up, as long as our tools don't tell us when we're making a mistake.</p>

<p>To take an example from JavaScript's history, I think it's fair to say that <a href="http://jslint.com/">JSLint</a> and <a href="http://jshint.com/">JSHint</a> did a greater service to the community than <a href="http://amzn.com/0596517742"><em>JavaScript: The Good Parts</em></a>, even though they effectively contain the same information. It's the difference between being told <em>exactly the mistake you just made in your code</em>, as opposed to reading a book where you try to understand other people's mistakes.</p>

<p>The beauty of ES7 <code>async</code>/<code>await</code> is that, for the most part, your mistakes will reveal themselves as syntax/compiler errors rather than subtle runtime bugs. Until then, though, it's good to have a grasp of what promises are capable of, and how to use them properly in ES5 and ES6.</p>

<p>So while I recognize that, like <em>JavaScript: The Good Parts</em>, this blog post can only have a limited impact, it's hopefully something you can point people to when you see them making these same mistakes. Because there are still way too many of us who just need to admit: "I have a problem with promises!"</p>

<div class="alert alert-info">


<div class="alert-text">


<p><strong>Update:</strong> it’s been pointed out to me that Bluebird 3.0 will <a href="http://imgur.com/a/t3xng">print out warnings</a> that can prevent many of the mistakes I’ve identified in this post. So using Bluebird is another great option while we wait for ES7!</p>

</div></div>

</div>
