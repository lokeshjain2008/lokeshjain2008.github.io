---
layout: post
date: Wed Jun 22 18:28:04 2016
comments: true
title: ruby scope deep dive
---
<article class="article" id="post-3135">
      <div class="grid grid--cling">
        <!-- Article Headline -->
        <div class="colxs100 article__headline">
            <h2>A Deep Dive into Ruby Scopes</h2>
            <span class="article__date">2016-03-16</span>
        </div>
        <!-- Article Overview -->
        <div class="article__overview">
          <div class="colxs100 colmd75 collg75">
                          <p class="article__by">by <a href="https://blog.codeship.com/author/danielclark/" title="Posts by Daniel P. Clark" rel="author">Daniel P. Clark</a> | <span class="article__commentCount"><a href="https://blog.codeship.com/a-deep-dive-into-ruby-scopes/#disqus_thread" data-disqus-identifier="3135 http://blog.codeship.com/?p=3135">7 Comments</a></span></p>

          </div>
          <div class="colxs100 colmd20 collg20 article__categories">
            <a class="category category-development" href="https://blog.codeship.com/category/development/" title="Development">Development</a>          </div>
        </div>
        <!-- Article Summery -->
        <summery class="article__summery colxs100">
                      <p>
              </p><p>The Ruby language was designed with a pure object-oriented approach. In Ruby, everything is an object.</p>
<p>Object-oriented design provides encapsulation for properties and actions. Encapsulation’s purpose is to protect methods and data from outside interference and misuse. With encapsulation, everything has certain scopes from which they may be utilized. Several categories of scope in Ruby are global, instance, and local scopes. These are the primary scopes within Ruby, but there are some outliers to the rules, such as class variables and the use of lexical scope with refinements.</p>
<p>Understanding Ruby scopes will go a long way in helping you fully leverage the language. I’ve compiled an in-depth overview to demonstrate how they can assist you with having a more beautiful code base.</p>
<p>
</p><div class="tm-tweet-clear"></div>
<div class="tm-click-to-tweet">
<div class="tm-ctt-text"><a href="https://twitter.com/share?text=%22Understanding+Ruby+scopes+will+go+a+long+way+in+helping+you+fully+leverage+the+language.%22&amp;url=https://blog.codeship.com/a-deep-dive-into-ruby-scopes/" target="_blank">“Understanding Ruby scopes will go a long way in helping you fully leverage the language.”</a></div>
<p><a href="https://twitter.com/share?text=%22Understanding+Ruby+scopes+will+go+a+long+way+in+helping+you+fully+leverage+the+language.%22&amp;url=https://blog.codeship.com/a-deep-dive-into-ruby-scopes/" target="_blank" class="tm-ctt-btn">Click To Tweet</a>
</p><div class="tm-ctt-tip"></div>
</div>
<h2>Encapsulation</h2>
<p>Let’s start out with an example of encapsulation with local variables. (Local variables can be created when you use the equals sign for assignment, such as <code>a = 1</code>.) First, I’ll show some code written within a begin-end block which has no encapsulation and then a simple method definition which does.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">begin</span>
  a <span class="token operator">=</span> <span class="token number">4</span>
<span class="token keyword">end</span>
puts a <span class="token keyword">if</span> <span class="token keyword">defined</span><span class="token operator">?</span><span class="token punctuation">(</span>a<span class="token punctuation">)</span>
<span class="token comment" spellcheck="true"># 4
</span>
<span class="token keyword">def</span> local_var_example
  b <span class="token operator">=</span> <span class="token number">4</span>
<span class="token keyword">end</span>
local_var_example
puts b <span class="token keyword">if</span> <span class="token keyword">defined</span><span class="token operator">?</span><span class="token punctuation">(</span>b<span class="token punctuation">)</span>
<span class="token comment" spellcheck="true"># =&gt; nil</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>Here we can clearly see that when we assigned the value 4 to the local variable <code>b</code> that the variable did not exist beyond the scope of the function. This way, you can write as much code as you want within the method and not worry about variables leaking out. Local variables are very scoped; you cannot write a local variable before a standard method definition and retrieve it.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby">a <span class="token operator">=</span> <span class="token string">"example"</span>
<span class="token keyword">def</span> a<span class="token operator">?</span>
  puts a
<span class="token keyword">end</span>

a<span class="token operator">?</span>
<span class="token comment" spellcheck="true">#NameError: undefined local variable or method `a' for main:Object</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>If you want to draw in the environment and access local scope from outside a method definition, you may use closure definitions such as <code>define_method</code>, <code>proc</code>, or <code>lambda</code>.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby">word <span class="token operator">=</span> <span class="token string">"moo"</span>

<span class="token keyword">define_method</span> <span class="token symbol">:x</span> <span class="token keyword">do</span>
  puts word
<span class="token keyword">end</span>
x
<span class="token comment" spellcheck="true"># moo
</span>
y <span class="token operator">=</span> proc <span class="token punctuation">{</span>puts word<span class="token punctuation">}</span>
y<span class="token punctuation">.</span>call
<span class="token comment" spellcheck="true"># moo
</span>
z <span class="token operator">=</span> lambda <span class="token punctuation">{</span>puts word<span class="token punctuation">}</span>
z<span class="token punctuation">.</span>call
<span class="token comment" spellcheck="true"># moo</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<h3>Caveat</h3>
<p>Local variables take precedence over methods of the same name. To explicitly ask for the method result when there’s a local variable of the same name, you can use the <code>send</code> method.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby">a <span class="token operator">=</span> <span class="token number">4</span>
<span class="token keyword">def</span> a
  <span class="token number">5</span>
<span class="token keyword">end</span>

puts a
<span class="token comment" spellcheck="true"># 4
</span>send <span class="token symbol">:a</span>
<span class="token comment" spellcheck="true"># =&gt; 5</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<h2>Instances</h2>
<p>With Ruby being an object-oriented language, we get to create multiple object instances of their class definitions. Every Ruby object is its own singleton instance. And I mean that purely by the definition of the word <em>singleton</em>: “a single person or thing of the kind under consideration.” If you had two identical human clones, they would still each be their own individual existence. It’s the same way in Object-Oriented Programming.</p>
<p>When you want to define a kind of object that you plan on having more than one instance of, you write a classification of the object with class.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">class</span> <span class="token class-name">Pet</span>
  <span class="token keyword">def</span> mood
    <span class="token string">"hungry"</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

cat <span class="token operator">=</span> <span class="token constant">Pet</span><span class="token punctuation">.</span><span class="token keyword">new</span>
<span class="token class-name">dog</span> <span class="token operator">=</span> <span class="token constant">Pet</span><span class="token punctuation">.</span><span class="token keyword">new</span>
<span class="token class-name">mouse</span> <span class="token operator">=</span> <span class="token constant">Pet</span><span class="token punctuation">.</span><span class="token keyword">new</span>

<span class="token class-name">cat<span class="token punctuation">.</span>mood</span>
<span class="token comment" spellcheck="true"># =&gt; "hungry"
</span>dog<span class="token punctuation">.</span>mood
<span class="token comment" spellcheck="true"># =&gt; "hungry"</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>The method <code>mood</code> is an instance method. It’s defined only on all instances created from the class Pet. The one place it is not defined, however, is on the classification of Pet itself.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token constant">Pet</span><span class="token punctuation">.</span>mood
<span class="token comment" spellcheck="true">#NoMethodError: undefined method `mood' for Pet:Class</span><span class="line-numbers-rows"><span></span><span></span></span></code></pre>
<p>The Pet class is not an instance of itself; it is a classification of the kind of objects you can propagate from it. This is the intent of Ruby’s class design, where it provides the <code>new</code> method for you to instantiate individual instances of this kind of class. So the scope of methods defined in this way are all for the objects that will be created from it.</p>
<p>Now it is possible to write methods for the class Pet itself and not for the instances created from it. To do this, we define a method on <code>self</code>. Here are two ways you may do this:</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">class</span> <span class="token class-name">Pet</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>definition
    <span class="token string">"Living thing belongs to an owner and is cared for.  Can be a plant, animal, or amoeba."</span>
  <span class="token keyword">end</span>

  <span class="token keyword">class</span> <span class="token operator">&lt;</span><span class="token operator">&lt;</span> <span class="token keyword">self</span>
    <span class="token keyword">def</span> free<span class="token operator">?</span>
      <span class="token string">"Not likely.  How much money do you have?"</span>
    <span class="token keyword">end</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">Pet</span><span class="token punctuation">.</span>definition
<span class="token comment" spellcheck="true"># =&gt; "Living thing belongs to an owner and is cared for.  Can be a plant, animal, or amoeba."
</span>
<span class="token constant">Pet</span><span class="token punctuation">.</span>free<span class="token operator">?</span>
<span class="token comment" spellcheck="true"># =&gt; "Not likely.  How much money do you have?"
</span>
dog <span class="token operator">=</span> <span class="token constant">Pet</span><span class="token punctuation">.</span><span class="token keyword">new</span>
<span class="token class-name">dog<span class="token punctuation">.</span>free</span><span class="token operator">?</span>
<span class="token comment" spellcheck="true">#NoMethodError: undefined method `free?' for #&lt;Pet:0x00000002845330&gt;</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>As you can see, the scope of methods defined on <code>self</code> within a class is only available on that singleton instance of the class. The created objects from this classification will not have those methods defined, as they were written specifically for the class Pet.</p>
<p>The same thing is true with modules. When you define a method with <code>def mood</code> in a module, it will only be available within the scope of classes that have it “included” (much like what the class method <code>new</code> does). And if you use the <code>self</code> identifier for defining a method on a module, it will only be available on that singleton instance of the module and not any class it is inherited in.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">module</span> <span class="token constant">Car</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>description
    <span class="token string">"A vehicle of transportation"</span>
  <span class="token keyword">end</span>

  <span class="token keyword">def</span> engine
    <span class="token string">"vroom"</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">Car</span><span class="token punctuation">.</span>description
<span class="token comment" spellcheck="true"># =&gt; "A vehicle of transportation"
</span><span class="token constant">Car</span><span class="token punctuation">.</span>engine
<span class="token comment" spellcheck="true">#NoMethodError: undefined method `engine' for Car:Module
</span>
<span class="token keyword">class</span> <span class="token class-name">Boxcar</span>
  include <span class="token constant">Car</span>
<span class="token keyword">end</span>

betsy <span class="token operator">=</span> <span class="token constant">Boxcar</span><span class="token punctuation">.</span><span class="token keyword">new</span>
<span class="token class-name">betsy<span class="token punctuation">.</span>engine</span>
<span class="token comment" spellcheck="true"># =&gt; "vroom"
</span>betsy<span class="token punctuation">.</span>description
<span class="token comment" spellcheck="true">#NoMethodError: undefined method `description' for #&lt;Boxcar:0x000000025e61c0&gt;</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>The scope of the methods defined are dependent on whether you assign it to the singleton instance of that object or let it be defined on instances from that object.</p>
<h2>Singleton Instance</h2>
<p>Saying “singleton instance” feels a bit repetitive to me, but it is important to specify so as not to confuse it with the Singleton Design Pattern or the <code>singleton_class</code> object which exists on most Ruby objects (which is not the singleton instance of the object it is on but is an extra singleton instance of its own).</p>
<p>Ruby is designed where everything is an instance of the Object class and therefore is a singleton instance, meaning that it exists as its own individual self. Yes, this may seem confusing at first, but once you see every module, class, and object as their own singleton instance which may or may not create more singleton instances from their definitions, then things become clearer.</p>
<h2>Global Scope</h2>
<p>When you write code at the top level, you are writing in global scope. Local variables will not cross over any scope, instance variables will become available to local methods, and methods and classes are available everywhere.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby">local_variable <span class="token operator">=</span> <span class="token number">1</span>     <span class="token comment" spellcheck="true"># not available in any other scope
</span>
<span class="token variable">@instance_variable</span> <span class="token operator">=</span> <span class="token number">2</span> <span class="token comment" spellcheck="true"># available within methods in the same scope
</span>
<span class="token variable">$global_variable</span> <span class="token operator">=</span> <span class="token number">3</span>   <span class="token comment" spellcheck="true"># available everywhere
</span>
<span class="token constant">CONSTANT</span> <span class="token operator">=</span> <span class="token number">4</span>           <span class="token comment" spellcheck="true"># available everywhere
</span>
<span class="token keyword">def</span> a_method           <span class="token comment" spellcheck="true"># available everywhere
</span><span class="token keyword">end</span>

<span class="token keyword">class</span> <span class="token class-name">Klass</span>            <span class="token comment" spellcheck="true"># available everywhere
</span><span class="token keyword">end</span>

<span class="token keyword">module</span> <span class="token constant">Mod</span>             <span class="token comment" spellcheck="true"># available everywhere
</span><span class="token keyword">end</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<blockquote>
<p>All of these, except for global variables, can be encapsulated within singleton instances and maintain the same behavior as described above.</p>
</blockquote>
<p>Now the way method definitions are managed in the global namespace is quite interesting. As you may recall that everything in Ruby is an object, they are all also instances of the Object class itself. So the way that global methods are handled is that they are defined as private instance methods on the Object class.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">def</span> hey_you
  <span class="token string">"it's me"</span>
<span class="token keyword">end</span>

<span class="token builtin">Object</span><span class="token punctuation">.</span>private_method_defined<span class="token operator">?</span> <span class="token symbol">:hey_you</span>
<span class="token comment" spellcheck="true"># =&gt; true
</span>
<span class="token builtin">Array</span><span class="token punctuation">.</span>send <span class="token symbol">:hey_you</span>
<span class="token comment" spellcheck="true"># =&gt; "it's me"
</span><span class="token number">12345</span><span class="token punctuation">.</span>send <span class="token symbol">:hey_you</span>
<span class="token comment" spellcheck="true"># =&gt; "it's me"
</span><span class="token keyword">nil</span><span class="token punctuation">.</span>send <span class="token symbol">:hey_you</span>
<span class="token comment" spellcheck="true"># =&gt; "it's me"</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>This is also how classes and modules are made available at lower levels of scope.</p>
<h2>Namespacing</h2>
<p>Namespacing is the practice of placing code within the scope of another class or module. This is a good practice for both clarifying purpose, usage, and to protect code from potential clashes with other people’s code. You may reuse class or module names within a namespace without overwriting the outer definitions.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">module</span> <span class="token constant">Help</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>me
    <span class="token string">"this is a general help"</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token keyword">module</span> <span class="token constant">Dog</span>
  <span class="token keyword">module</span> <span class="token constant">Help</span>
    <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>me
      <span class="token string">"woof woof woof woof"</span>
    <span class="token keyword">end</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">Help</span><span class="token punctuation">.</span>me
<span class="token comment" spellcheck="true"># =&gt; "this is a general help"
</span><span class="token constant">Dog</span><span class="token punctuation">:</span><span class="token symbol">:Help</span><span class="token punctuation">.</span>me
<span class="token comment" spellcheck="true"># =&gt; "woof woof woof woof"</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>You’ve protected your code from overwriting the other Help object by namespacing one specifically for Dog. If you want access to constants, classes, or modules at the top level of scope, you may use a double-colon <code>::</code> before the object to access it.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token constant">CONSTANT</span> <span class="token operator">=</span> <span class="token string">"world"</span>

<span class="token keyword">module</span> <span class="token constant">Greeter</span>
  <span class="token constant">CONSTANT</span> <span class="token operator">=</span> <span class="token string">"hello"</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>greet
    puts <span class="token constant">CONSTANT</span> <span class="token operator">+</span> <span class="token string">" "</span> <span class="token operator">+</span> <span class="token punctuation">:</span><span class="token symbol">:CONSTANT</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">Greeter</span><span class="token punctuation">.</span>greet
<span class="token comment" spellcheck="true"># hello world</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<h2>Refinements</h2>
<p>In Ruby, you can reopen every object to add or make changes to it. Making changes outside of the scope of the original definition is known as <em>monkey patching</em>.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">class</span> <span class="token class-name">Warn</span>
  <span class="token keyword">def</span> warn
    <span class="token string">"original behavior"</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token keyword">class</span> <span class="token class-name">Warn</span>
  alias_method <span class="token symbol">:_warn</span><span class="token punctuation">,</span> <span class="token symbol">:warn</span>
  <span class="token keyword">def</span> warn
    <span class="token string">"not "</span> <span class="token operator">+</span> _warn
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">Warn</span><span class="token punctuation">.</span><span class="token keyword">new</span><span class="token punctuation">.</span>warn
<span class="token comment" spellcheck="true"># =&gt; "not original behavior"</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>The problem with monkey patching is that the changes happen globally. Any other place in your code base where others have used this object and method has now been changed. Very often this is how things will break; when depended-upon code is modified globally, everyone experiences the change.</p>
<p>Ruby’s solution for this is to use <em>refinements</em>. Refinements allow you to do the same thing as monkey patching but restrict the changes only to the very specific places you specify to use it. This way you won’t break anyone else’s code because your changes are lexically scoped.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">module</span> <span class="token constant">FixForMe</span>
  refine <span class="token builtin">String</span> <span class="token keyword">do</span>
    alias_method <span class="token symbol">:_to_s</span><span class="token punctuation">,</span> <span class="token symbol">:to_s</span>
    <span class="token keyword">def</span> to_s
      <span class="token string">"not "</span> <span class="token operator">+</span> _to_s
    <span class="token keyword">end</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token keyword">class</span> <span class="token class-name">A</span>
  using <span class="token constant">FixForMe</span>
  <span class="token keyword">def</span> a
    <span class="token string">"to be"</span><span class="token punctuation">.</span>to_s
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token keyword">class</span> <span class="token class-name">B</span>
  <span class="token keyword">def</span> b
    <span class="token string">"to be"</span><span class="token punctuation">.</span>to_s
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">A</span><span class="token punctuation">.</span><span class="token keyword">new</span><span class="token punctuation">.</span>a
<span class="token comment" spellcheck="true"># =&gt; "not to be"
</span><span class="token constant">B</span><span class="token punctuation">.</span><span class="token keyword">new</span><span class="token punctuation">.</span>b
<span class="token comment" spellcheck="true"># =&gt; "to be"</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>Here we have changed the behavior for <code>String#to_s</code> only where we’ve written <code>using FixForMe</code>, and the <code>to_s</code> behavior did not change in class <code>B</code>. This is how lexical scope works.</p>
<p>Lexical scope only goes as far as the visual block of code before you. If you reopen a class and don’t write the <code>using</code> syntax in it, the refinements behavior will not be there even if you’ve previously used it in the same class. Refinements are well worth using to avoid the pains that monkey patching may bring.</p>
<h2>Binding: The Exception to Scope</h2>
<p>The Binding object is the only object that lets you pass and modify local variables out of scope. To create a binding, you simply type the method <code>binding</code>, and it creates a binding of the local environment. You may pass this binding into other scopes and access the local variables from where the binding was instantiated.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">module</span> <span class="token constant">A</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span><span class="token function">a<span class="token punctuation">(</span></span>bnd<span class="token punctuation">)</span>
    printf <span class="token string">"%s\n"</span><span class="token punctuation">,</span> bnd<span class="token punctuation">.</span>local_variables

    x <span class="token operator">=</span> bnd<span class="token punctuation">.</span>local_variable_get <span class="token symbol">:x</span>
    y <span class="token operator">=</span> bnd<span class="token punctuation">.</span>local_variable_get <span class="token symbol">:y</span>
    z <span class="token operator">=</span> bnd<span class="token punctuation">.</span>local_variable_get <span class="token symbol">:z</span>

    printf <span class="token string">"%s\n"</span><span class="token punctuation">,</span> <span class="token punctuation">[</span>x<span class="token punctuation">,</span> y<span class="token punctuation">,</span> z<span class="token punctuation">]</span>

    bnd<span class="token punctuation">.</span><span class="token function">local_variable_set<span class="token punctuation">(</span></span><span class="token symbol">:z</span><span class="token punctuation">,</span> x <span class="token operator">+</span> y<span class="token punctuation">)</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token keyword">module</span> <span class="token constant">B</span>
  <span class="token keyword">def</span> <span class="token keyword">self</span><span class="token punctuation">.</span>b
    x <span class="token operator">=</span> <span class="token number">1</span>
    y <span class="token operator">=</span> <span class="token number">7</span>
    z <span class="token operator">=</span> <span class="token number">0</span>

    <span class="token constant">A</span><span class="token punctuation">.</span><span class="token function">a<span class="token punctuation">(</span></span>binding<span class="token punctuation">)</span>

    puts "x <span class="token operator">+</span> y <span class="token operator">=</span> <span class="token comment" spellcheck="true">#{z}"
</span>  <span class="token keyword">end</span>
<span class="token keyword">end</span>

<span class="token constant">B</span><span class="token punctuation">.</span>b
<span class="token comment" spellcheck="true"># [:x, :y, :z]
</span><span class="token comment" spellcheck="true"># [1, 7, 0]
</span><span class="token comment" spellcheck="true"># x + y = 8</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>The local variable <code>z</code> has been changed from a different scope in <code>A</code>, and the result was within <code>B</code>.</p>
<h2>Class Variables</h2>
<p>Class variables are rarely used as the scope is broadened to all instances of the same class. If you were to modify the value of a class variable in one instance, it will be changed for all other instances.</p>
<pre class="line-numbers language-ruby"><code class=" language-ruby"><span class="token keyword">class</span> <span class="token class-name">Building</span>
  <span class="token keyword">def</span> initialize
    <span class="token variable">@@state</span> <span class="token operator">||</span><span class="token operator">=</span> <span class="token symbol">:built</span>
  <span class="token keyword">end</span>

  <span class="token keyword">def</span> <span class="token function">state<span class="token punctuation">(</span></span>value <span class="token operator">=</span> <span class="token keyword">nil</span><span class="token punctuation">)</span>
    <span class="token variable">@@state</span> <span class="token operator">=</span> value <span class="token keyword">if</span> value
    <span class="token variable">@@state</span>
  <span class="token keyword">end</span>
<span class="token keyword">end</span>

library <span class="token operator">=</span> <span class="token constant">Building</span><span class="token punctuation">.</span><span class="token keyword">new</span>
<span class="token class-name">office</span> <span class="token operator">=</span> <span class="token constant">Building</span><span class="token punctuation">.</span><span class="token keyword">new</span>

<span class="token class-name">library<span class="token punctuation">.</span>state</span>
<span class="token comment" spellcheck="true"># =&gt; :built
</span>office<span class="token punctuation">.</span>state
<span class="token comment" spellcheck="true"># =&gt; :built
</span>
office<span class="token punctuation">.</span>state <span class="token symbol">:demolished</span>
<span class="token comment" spellcheck="true"># =&gt; :demolished
</span>library<span class="token punctuation">.</span>state
<span class="token comment" spellcheck="true"># =&gt; :demolished</span><span class="line-numbers-rows"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></span></code></pre>
<p>As you can see, using class variables may cause surprise values in your other classes if they aren’t managed properly. It would probably be wise to think of using these variables for either read-only values or by having a thread-safe system in place.</p>
<h2>Conclusion</h2>
<p>Ruby is a language that has been designed to make programmers happy, and understanding its scope gives you full leverage in using the language. With it, you may employ many strategies in design that help you toward having a more beautiful code base.</p>
<p>I recommend studying good object-oriented design. Each language/feature is a tool, and tools are most effective when understood and mastered. Encapsulation as a core design in Ruby will serve you well if you use it in the way it was designed to be used. Thankfully Ruby is a very flexible language, so we do have a lot of free reign in how we use it.</p>
<p>
</p><div class="tm-tweet-clear"></div>
<div class="tm-click-to-tweet">
<div class="tm-ctt-text"><a href="https://twitter.com/share?text=%22Study+good+object-oriented+design%3B+tools+are+most+effective+when+mastered.%22+via+%406ftdan&amp;url=https://blog.codeship.com/a-deep-dive-into-ruby-scopes/" target="_blank">“Study good object-oriented design; tools are most effective when mastered.” via @6ftdan</a></div>
<p><a href="https://twitter.com/share?text=%22Study+good+object-oriented+design%3B+tools+are+most+effective+when+mastered.%22+via+%406ftdan&amp;url=https://blog.codeship.com/a-deep-dive-into-ruby-scopes/" target="_blank" class="tm-ctt-btn">Click To Tweet</a>
</p><div class="tm-ctt-tip"></div>
</div>
            <p></p>
                  </summery>
      </div>
    </article>

<div>
	Note : copied from <a href="https://blog.codeship.com/a-deep-dive-into-ruby-scopes/" rel="bookmark">
	codeship blog
	</a>
</div>
