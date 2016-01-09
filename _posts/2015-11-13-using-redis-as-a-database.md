---
layout: post
date: "Fri Nov 13 14:01:59 2015"
comments: true
title: "using redis as a database"
---

<p>I was spiking on Redis recently.  I wanted to use the <a href="https://github.com/nateware/redis-objects">redis-objects gem</a> to simulate a shopping cart app even though the README specifically says</p>

<blockquote>
  <p>Just use MySQL, k?</p>
</blockquote>

<p>I wanted to see what would happen if I tried it anyway.  So the README and examples for the redis-objects gem are great so I’m not going to rehash what’s there.  However, I will say though that the example has you hardcode the id field to 1.  That detail snuck up on me.</p>

<!-- more -->

<p>If you don’t set an ID then you can’t work with a redis-object instance.  You get an exception: <code>Redis::Objects::NilObjectId: Attempt to address redis-object :name on class User with nil id (unsaved record?)</code></p>

<p>It’s basically trying to tell you, “hey, save the record first or set an ID”.  Well, honestly, I don’t want to set an id myself.  This is where the meat of the README is.  Redis-objects really fits organically in an existing ActiveRecord model.  That means Rails.  In this case though, I don’t want an entire Rails app.  I can see the value though in a plain old Rails app.  Just look at the examples if you want to see more.</p>

<p>Anyway, continuing on with the spiking, I tried to integrate the Supermodel gem with Redis-objects.  That sort of worked.  You just <code>class User &lt; Supermodel::Base</code> and you can sort of get it to work.  This is great because Supermodel gives you finders like <code>User.find_by_email('bob@yahoo.com')</code> to make it act like ActiveRecord but you can’t use <code>.create(email: 'bob@yahoo.com')</code> to begin with because of the same errors as I mentioned above.  Redis-objects really wants the record to have an ID already.  Even using Supermodel’s RandomID mixin didn’t work.  The initialize order and callback hooks don’t really work (or at least I couldn’t get them to work).</p>

<p>Finally, I tried combining just redis-objects and datamapper redis.  That worked.  And it’s pretty nice.  Check it out.</p>

<div class="highlight"><pre><code class="language-ruby" data-lang="ruby"><span class="nb">require</span> <span class="s1">'redis-objects'</span>
<span class="nb">require</span> <span class="s1">'dm-core'</span>
<span class="nb">require</span> <span class="s1">'dm-redis-adapter'</span>

<span class="no">DataMapper</span><span class="o">.</span><span class="n">setup</span><span class="p">(</span><span class="ss">:default</span><span class="p">,</span> <span class="p">{</span><span class="ss">:adapter</span>  <span class="o">=&gt;</span> <span class="s2">"redis"</span><span class="p">})</span>

<span class="c1"># you would move this to a common location</span>
<span class="no">Redis</span><span class="o">.</span><span class="n">current</span> <span class="o">=</span> <span class="no">Redis</span><span class="o">.</span><span class="n">new</span><span class="p">(</span><span class="ss">:host</span> <span class="o">=&gt;</span> <span class="s1">'127.0.0.1'</span><span class="p">,</span> <span class="ss">:port</span> <span class="o">=&gt;</span> <span class="mi">6379</span><span class="p">)</span>

<span class="k">class</span> <span class="nc">User</span>
  <span class="kp">include</span> <span class="no">Redis</span><span class="o">::</span><span class="no">Objects</span>
  <span class="kp">include</span> <span class="no">DataMapper</span><span class="o">::</span><span class="no">Resource</span>

  <span class="c1"># datamapper fields, just used for .create</span>
  <span class="n">property</span> <span class="ss">:id</span><span class="p">,</span> <span class="no">Serial</span>
  <span class="n">property</span> <span class="ss">:email</span><span class="p">,</span> <span class="nb">String</span>

  <span class="c1"># use redis-objects fields for everything else</span>
  <span class="n">value</span> <span class="ss">:disabled</span>
  <span class="n">value</span> <span class="ss">:name</span>
  <span class="n">list</span> <span class="ss">:cart</span><span class="p">,</span> <span class="ss">:marshal</span> <span class="o">=&gt;</span> <span class="kp">true</span>

<span class="k">end</span>

<span class="c1"># absolutely need this line for dm-redis</span>
<span class="no">User</span><span class="o">.</span><span class="n">finalize</span></code></pre></div>

<p>So using this is pretty easy.</p>

<div class="highlight"><pre><code class="language-ruby" data-lang="ruby"><span class="n">u</span> <span class="o">=</span> <span class="no">User</span><span class="o">.</span><span class="n">create</span><span class="p">(</span><span class="ss">email</span><span class="p">:</span> <span class="s1">'test@test.com'</span><span class="p">)</span>
<span class="n">u</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="s1">'Testy McTesterson'</span></code></pre></div>

<p>When you look at Redis, the keys are already composited for you and magic has happened.</p>

<pre>redis 127.0.0.1:6379&gt; keys *
user:test@test.com:name

redis 127.0.0.1:6379&gt; get user:test@test.com:name
Testy McTesterson
</pre>

<p>Yay!</p>

<p>The name field is from redis-objects and the create uses datamapper.  This is a really odd pairing but I like the fact that I have no sql database in the mix but still have finders similar to an ORM.  Something to keep in mind, datamapper’s finders are a bit different than the Rails 3 ones (no .where method).</p>

<h2 id="benchmarking-a-million-things">Benchmarking A Million Things</h2>

<p>Ok fine.  So maybe this works, maybe it doesn’t.  Maybe it’s not the right idea.  What about the good stuff?  Like, how fast can we load a whole lot of names into MySQL versus Redis using  the above code and techniques?  Is it even relevant?</p>

<pre>Summary
-------------------------------------------------------------------------------
(PL = pipelined redis operation)

Loading one million random names (full names) like John Smith, Patty Gerbee Sr)
MySQL:                   06:05
Redis:                   02:45
Redis C ext              01:32
Redis pipelined:         00:56
Redis pipelined C ext:   00:19
Ruby just loading array: 387ms

Loading 10k ecommerce-style data (orders, users, products)
MySQL:    00:09.40
Redis:    00:14.50
Redis PL: 00:02.72
</pre>

<p>A gist of these <a href="https://gist.github.com/squarism/5234519">test results is here</a>.</p>

<h2 id="a-more-complete-example">A More Complete Example</h2>

<p>If you know the ID and don’t need something like an auto-incrementing column outside your code/control then you can greatly simplify the code above by getting rid of Datamapper.  You can simply use redis-objects to fake an ORM.  I had great success using it as long as you <em>USE NATIVE REDIS TYPES</em>.  Listen to the redis-objects author, don’t try to force the tool into the use case.</p>

<div class="highlight"><pre><code class="language-ruby" data-lang="ruby"><span class="c1"># What if we want to use redis-objects as a database but</span>
<span class="c1"># try to stick with native redis objects?</span>
<span class="c1">#</span>
<span class="c1"># For example, Supermodel is a great gem but using the Redis</span>
<span class="c1"># mixin causes Supermodel to serialize to JSON strings in Redis</span>
<span class="c1"># which is going to kill performance.  You have to model your</span>
<span class="c1"># problem using native Redis objects to keep the speed up.</span>
<span class="c1">#</span>
<span class="c1"># At the same time, I miss the finders from ActiveModel</span>
<span class="c1"># like: Person.find('Joe')</span>
<span class="c1"># Supermodel does give you those finders so you will feel right at</span>
<span class="c1"># home coming from Rails.  I tried using ActiveModel mixins with</span>
<span class="c1"># redis-objects but it didn't work for me.</span>
<span class="c1">#</span>
<span class="c1"># I found the below a nice compromise but it requires a lot of</span>
<span class="c1"># custom methods.  :(</span>

<span class="nb">require</span> <span class="s1">'redis-objects'</span>

<span class="k">class</span> <span class="nc">Person</span>
  <span class="kp">attr_reader</span> <span class="ss">:name</span>
  <span class="k">alias</span> <span class="ss">:id</span> <span class="ss">:name</span>

  <span class="kp">include</span> <span class="no">Redis</span><span class="o">::</span><span class="no">Objects</span>

  <span class="k">def</span> <span class="nf">initialize</span> <span class="nb">name</span>
    <span class="vi">@name</span> <span class="o">=</span> <span class="nb">name</span>
  <span class="k">end</span>

  <span class="k">def</span> <span class="nc">self</span><span class="o">.</span><span class="nf">exists?</span> <span class="nb">name</span>
    <span class="c1"># Here's a big assumption, if the id attribute exists, the entire</span>
    <span class="c1"># object exists.  This might not work for your problem.</span>
    <span class="nb">self</span><span class="o">.</span><span class="n">redis</span><span class="o">.</span><span class="n">exists</span> <span class="s2">"name:{#name}:id"</span>
  <span class="k">end</span>

  <span class="k">def</span> <span class="nc">self</span><span class="o">.</span><span class="nf">find</span> <span class="nb">name</span>
    <span class="c1"># new behaves like find when a record exists, so this works like</span>
    <span class="c1"># find_or_create()</span>
    <span class="nb">self</span><span class="o">.</span><span class="n">new</span> <span class="nb">name</span>
  <span class="k">end</span>

  <span class="c1"># native redis attributes with redis-objects</span>
  <span class="n">value</span> <span class="ss">:age</span>
  <span class="n">list</span> <span class="ss">:favorite_foods</span>
<span class="k">end</span>

<span class="c1"># example usage</span>

<span class="n">joe</span> <span class="o">=</span> <span class="no">Person</span><span class="o">.</span><span class="n">new</span> <span class="s1">'Joe'</span>
<span class="n">joe</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="mi">34</span>
<span class="n">joe</span><span class="o">.</span><span class="n">favorite_foods</span> <span class="o">&lt;&lt;</span> <span class="o">[</span><span class="s1">'cake'</span><span class="p">,</span> <span class="s1">'pie'</span><span class="o">]</span>  <span class="c1"># it will flatten arrays, don't worry</span>
<span class="n">joe</span><span class="o">.</span><span class="n">favorite_foods</span> <span class="o">&lt;&lt;</span> <span class="s1">'bacon'</span>          <span class="c1"># or you can do this</span>

<span class="no">Person</span><span class="o">.</span><span class="n">find</span><span class="p">(</span><span class="s1">'Joe'</span><span class="p">)</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="mi">56</span>

<span class="c1"># find and initialize</span>
<span class="no">Person</span><span class="o">.</span><span class="n">find</span><span class="p">(</span><span class="s1">'Stan'</span><span class="p">)</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="mi">21</span>

<span class="c1"># you cannot just .favorite_foods = ['Steak]' because that's not how native</span>
<span class="c1"># Redis objects work</span>
<span class="no">Person</span><span class="o">.</span><span class="n">find</span><span class="p">(</span><span class="s1">'Stan'</span><span class="p">)</span><span class="o">.</span><span class="n">favorite_foods</span> <span class="o">&lt;&lt;</span> <span class="s1">'Steak'</span>

<span class="c1"># deleting a field</span>
<span class="no">Person</span><span class="o">.</span><span class="n">find</span><span class="p">(</span><span class="s1">'Stan'</span><span class="p">)</span><span class="o">.</span><span class="n">favorite_foods</span><span class="o">.</span><span class="n">del</span>  <span class="c1"># notice it's .del and not .delete (del is the redis cmd)</span></code></pre></div>
</div>

----
- Note: copied from [link](http://squarism.com/2013/05/04/using-redis-as-a-database/)
