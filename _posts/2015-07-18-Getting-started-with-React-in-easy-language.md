---
layout: post
date: "Sat Jul 18 21:04:42 2015"
comments: true
title: "Getting started with React in easy language"
tags: [react js, react_js, javascript, getting started with reactjs]
---
 Disclaimer: This post is directly copied from this [Blog](http://blog.41studio.com/getting-started-of-reactjs/).So that i will not loose this.


 <article class="post">
<span class="post-meta"><time datetime="2015-07-10">10 Jul 2015</time> </span>
<h1 class="post-title" style="font-size:42px;">Getting Started and Learn Concepts of ReactJS</h1>
<section class="post-content align-justify">
<p><img src="http://i1164.photobucket.com/albums/q578/ujangoleh/Resources-to-Get-You-Started-with-ReactJS.jpg" border="0" alt=" photo Resources-to-Get-You-Started-with-ReactJS.jpg" class="full-img"></p>
<p>Today we kick off the first of a new series of tutorials, <strong>learn react</strong>, which on becoming proficient and effective with Facebook’s React library. <br>
Before you start to build something meaningful, it is important to cover some basics first, <br>
then lets get this party started!</p>
<h3 id="whatisreact">What is React?</h3>
<p>React is a library of user interface developed in Facebook to facilitate the creation of interactive components, state and reusable user interface. used in Facebook in production, and Instagram.com is written entirely in React.</p>
<p>One of its unique selling points is that not only run on the client, but can also be displayed on the server, and can work together inter-operably.</p>
<p>It also uses a concept called the Virtual DOM that selectively renders subtrees of nodes based upon state changes. It does the least amount of DOM manipulation possible in order to keep your components up to date.</p>
<h3 id="howdoesthevirtualdomwork">How does the Virtual DOM work?</h3>
<p>imagine you had an object that you modeled around a person. It had every relevant property a person could possibly have, and mirrored the persons current state. <br>
This is basically what React does with the DOM.</p>
<p>Now think about if you took that object and made some changes. Added a mustache, some sweet biceps and Steve Buscemi eyes. <br>
In React-land, when we apply these changes, two things take place. First, React runs a “diffing” algorithm, which identifies what has changed. <br>
The second step is reconciliation, where it updates the DOM with the results of diff.</p>
<p>React forming the works, instead of taking the real person and rebuild from scratch, just change the face and arms. This means that if you have a text in an input and a render took place, as long as the parent node entry was not scheduled for reconciliation, the text would remain undisturbed.</p>
<p>Because React is using a fake DOM and not a real one, it also opens up a fun new possibility. We can render that fake DOM on the server, and voila, server side React views. <br>
<br> </p>
<h3 id="gettingstarted">Getting Started</h3>
<p><img src="http://i1164.photobucket.com/albums/q578/ujangoleh/maxresdefault_2.jpg" border="0" alt=" photo maxresdefault_2.jpg" class="full-img"> <br>
Getting started with React is as simple as downloading their provided starter kit:<br> <br>
<a href="http://facebook.github.io/react/downloads/react-0.11.2.zip">React Starter Kit</a><br> <br>
You can also fork a JSFiddle they have provided:<br> <br>
<a href="http://jsfiddle.net/vjeux/kb3gN/">React JSFiddle</a></p>
<h4 id="pagesetup">Page Setup</h4>
<p>When setting up your page, you want to include <code>react.js</code> and <code>JSXTransformer.js</code>, and then write your component in a script node with type set to <code>text/jsx</code>:</p>
<p> </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #d0d0d0">&lt;!DOCTYPE</span> <span style="color: #d0d0d0">html&gt;</span> <br>
<span style="color: #d0d0d0">&lt;html&gt;</span> <br>
  <span style="color: #d0d0d0">&lt;head&gt;</span>
    <span style="color: #d0d0d0">&lt;script</span> <span style="color: #d0d0d0">src=</span><span style="color: #ed9d13">"build/react.js"</span><span style="color: #d0d0d0">&gt;&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/script&gt;</span>
    <span style="color: #d0d0d0">&lt;script</span> <span style="color: #d0d0d0">src=</span><span style="color: #ed9d13">"build/JSXTransformer.js"</span><span style="color: #d0d0d0">&gt;&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/script&gt;</span>
  <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/head&gt;</span>
  <span style="color: #d0d0d0">&lt;body&gt;</span>
    <span style="color: #d0d0d0">&lt;div</span> <span style="color: #d0d0d0">id=</span><span style="color: #ed9d13">"mount-point"</span><span style="color: #d0d0d0">&gt;&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/div&gt;</span>
    <span style="color: #d0d0d0">&lt;script</span> <span style="color: #d0d0d0">type=</span><span style="color: #ed9d13">"text/jsx"</span><span style="color: #d0d0d0">&gt;</span>
      <span style="color: #999999; font-style: italic">// React Code Goes Here</span>
    <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/script&gt;</span>
  <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/body&gt;</span>
<span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/html&gt;</span> <br>
</pre></div><p></p>
<p>In React, components mount to an element, so in this example we can use the div <code>mount-point</code> as it’s parent container.</p>
<p>Although this is the easiest way to start, when its time to actually build something, it's probably a good idea to use Browserify or webpack and determine the components in separate files.</p>
<h4 id="thebasics">The Basics</h4>
<p>React’s basic building blocks are called components. Lets write one: <br>
 </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #d0d0d0">&lt;script</span> <span style="color: #d0d0d0">type=</span><span style="color: #ed9d13">"text/jsx"</span><span style="color: #d0d0d0">&gt;</span> <br>
    <span style="color: #999999; font-style: italic">/** @jsx React.DOM */</span>
    <span style="color: #d0d0d0">React.render(</span>
        <span style="color: #d0d0d0">&lt;h1&gt;Hello,</span> <span style="color: #d0d0d0">world!&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/h1&gt;,</span>
        <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'myDiv'</span><span style="color: #d0d0d0">)</span>
    <span style="color: #d0d0d0">);</span>
<span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/script&gt;</span> <br>
</pre></div><p></p>
<p>If you haven’t seen one of these before, you are probably wondering what Javascript/HTML chimera sorcery is taking place right now.</p>
<h4 id="jsx">JSX</h4>
<p>it's called JSX and it's a javascript syntax transform. JSX let you write some kind of HTML tag in javascript. I say "some kind of HTML" because there are a couple gotchas. You are really just writing XML based object representations.</p>
<p>For regular html tags, the <code>class</code> attribute is <code>className</code> and the <code>for</code> attribute is <code>htmlFor</code> in JSX because these are reserved words in Javascript. More differences can be <a href="http://facebook.github.io/react/docs/jsx-gotchas.html">Found here</a>.</p>
<p>Now you didn't need to use JSX, here is what the syntax looks like without it: <br>
 </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #999999; font-style: italic">/** @jsx React.DOM */</span> <br>
<span style="color: #d0d0d0">React.render(</span> <br>
  <span style="color: #d0d0d0">React.DOM.h1(</span><span style="color: #6ab825; font-weight: bold">null</span><span style="color: #d0d0d0">,</span> <span style="color: #ed9d13">'Hello, world!'</span><span style="color: #d0d0d0">),</span>
  <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'myDiv'</span><span style="color: #d0d0d0">)</span>
<span style="color: #d0d0d0">);</span> <br>
</pre></div> <br>
You can read more about element <a href="http://facebook.github.io/react/docs/tags-and-attributes.html">support</a> here.<p></p>
<p>I our first snippet, you noticed the <code>/** @jsx React.DOM */</code> at the top of the script. This is important, because it tells React that we using JSX. that this markup needs to be transformed, so u need it when using JSX syntax.</p>
<h4 id="components">Components</h4>
<p>when we using the <code>render</code> method above, our first argument is the component we want to render, and the second is the DOM node it should mount to. <br>
we can use the method of <code>createClass</code> to create custom component classes. It takes an object of specifications as it’s argument. Lets create one now :</p>
<p> </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">MyComponent</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
    <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
        <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
            <span style="color: #d0d0d0">&lt;h1&gt;Hello,</span> <span style="color: #d0d0d0">world!&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/h1&gt;</span>
        <span style="color: #d0d0d0">);</span>
    <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span> <br>
</pre></div><p></p>
<p>After creating a class we can render it to our document like so: <br>
 </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #d0d0d0">React.render(</span> <br>
    <span style="color: #d0d0d0">&lt;MyComponent/&gt;,</span>
    <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'myDiv'</span><span style="color: #d0d0d0">)</span>
<span style="color: #d0d0d0">);</span> <br>
</pre></div><p></p>
<p>Awsome, right?</p>
<h4 id="props">Props</h4>
<p>When we use our defined components, we can add attributes named props. These attributes are available in our component as <code>this.props</code> and can be used in our method of procedure for render dynamic data:</p>
<p> </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">MyComponent</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
    <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
        <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
            <span style="color: #d0d0d0">&lt;h1&gt;Hello,</span> <span style="color: #d0d0d0">{</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.props.name}!&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/h1&gt;</span>
        <span style="color: #d0d0d0">);</span>
    <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span><p></p>

<p><span style="color: #d0d0d0">React.render(&lt;MyComponent</span> <span style="color: #d0d0d0">name=</span><span style="color: #ed9d13">"Handsome"</span> <span style="color: #d0d0d0">/&gt;,</span> <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'myDiv'</span><span style="color: #d0d0d0">));</span> <br>
</p></pre></div> <br>
<br> <p></p>
<h3 id="specslifecyclestate">Specs, Lifecycle &amp; State</h3>
<p>The <code>render</code> method is the only specifications required for the creation of a component, but there are several methods and the technical specifications of the life cycle we can use that are helpful when you really want to brave the component to do anything.</p>
<h4 id="lifecyclemethods">Lifecycle Methods</h4>
<p></p><ul><li>componentWillMount – Invoked once, on both client &amp; server before rendering occurs.</li> <br>
<li>componentDidMount – Invoked once, only on the client, after rendering occurs.</li> <br>
<li>shouldComponentUpdate – Return value determines whether component should update.</li> <br>
<li>componentWillUnmount – Invoked prior to unmounting component.</li></ul>.<p></p>
<h4 id="specs">Specs</h4>
<p></p><ul><li>getInitialState – Return value is the initial value for state.</li> <br>
<li>getDefaultProps – Sets fallback props values if props aren’t supplied.</li> <br>
<li>mixins – An array of objects, used to extend the current component’s functionality.</li></ul>.<p></p>
<p>There are several more specs &amp; lifecycle methods that you can read about <a href="http://facebook.github.io/react/docs/component-specs.html">here</a>.</p>
<h4 id="state">State</h4>
<p>Every component has a <code>state</code> object and a <code>props</code> object. State is set using the <code>setState</code> method. Calling <code>setState</code> triggers UI updates and is the bread and butter of React’s interactivity. If we want to set an initial state before any interaction occurs we can use the <code>getInitialState</code> method. Below, see how we can set our component’s state:</p>
<p> </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">MyComponent</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
    <span style="color: #d0d0d0">getInitialState:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
        <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">{</span>
            <span style="color: #d0d0d0">count:</span> <span style="color: #3677a9">5</span>
        <span style="color: #d0d0d0">}</span>
    <span style="color: #d0d0d0">},</span>
    <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
        <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
            <span style="color: #d0d0d0">&lt;h1&gt;{</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.count}&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/h1&gt;</span>
        <span style="color: #d0d0d0">)</span>
    <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span> <br>
</pre></div><p></p>
<h4 id="events">Events</h4>
<p>React has also incorporated a system of events cross browser. The events are attached as component properties and can trigger methods. We will do our count increase using events:</p>
<p> </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #999999; font-style: italic">/** @jsx React.DOM */</span><p></p>

<p><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">Counter</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
  <span style="color: #d0d0d0">incrementCount:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
    <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.setState({</span>
      <span style="color: #d0d0d0">count:</span> <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.count</span> <span style="color: #d0d0d0">+</span> <span style="color: #3677a9">1</span>
    <span style="color: #d0d0d0">});</span>
  <span style="color: #d0d0d0">},</span>
  <span style="color: #d0d0d0">getInitialState:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
     <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">{</span>
       <span style="color: #d0d0d0">count:</span> <span style="color: #3677a9">0</span>
     <span style="color: #d0d0d0">}</span>
  <span style="color: #d0d0d0">},</span>
  <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
    <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
      <span style="color: #d0d0d0">&lt;div</span> <span style="color: #6ab825; font-weight: bold">class</span><span style="color: #d0d0d0">=</span><span style="color: #ed9d13">"my-component"</span><span style="color: #d0d0d0">&gt;</span>
        <span style="color: #d0d0d0">&lt;h1&gt;Count:</span> <span style="color: #d0d0d0">{</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.count}&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/h1&gt;</span>
        <span style="color: #d0d0d0">&lt;button</span> <span style="color: #d0d0d0">type=</span><span style="color: #ed9d13">"button"</span> <span style="color: #d0d0d0">onClick={</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.incrementCount}&gt;Increment&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/button&gt;</span>
      <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/div&gt;</span>
    <span style="color: #d0d0d0">);</span>
  <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span></p>

<p><span style="color: #d0d0d0">React.render(&lt;Counter/&gt;,</span> <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'mount-point'</span><span style="color: #d0d0d0">));</span> <br>
</p></pre></div> <br>
<br> <p></p>
<h3 id="unidirectionaldataflow">Unidirectional Data Flow</h3>
<p>In React, application data flows unidirectionally via the <code>state</code> and <code>props</code> objects, as opposed to the two-way binding of libraries like Angular. <br>
This means that, in a hierarchy of several components, a common component of the parents should manage the state and clean the chain through support.</p>
<p>Your state should be updated using the <code>setState</code> method to ensure that a UI refresh will occur, if necessary. The resulting values should be passed down to child components using attributes that are accessible in said children via <code>this.props</code>.</p>
<p>this is the example that shows this concept in practice: <br>
 </p><div style="background: #202020; overflow:auto;width:auto;border:solid gray;border-width:.1em .1em .1em .8em;padding:.2em .6em;"><pre style="margin: 0; line-height: 125%"><span style="color: #999999; font-style: italic">/** @jsx React.DOM */</span><p></p>

<p><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">FilteredList</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
  <span style="color: #d0d0d0">filterList:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(event){</span>
    <span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">updatedList</span> <span style="color: #d0d0d0">=</span> <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.initialItems;</span>
    <span style="color: #d0d0d0">updatedList</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">updatedList.filter(</span><span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(item){</span>
      <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">item.toLowerCase().search(</span>
        <span style="color: #d0d0d0">event.target.value.toLowerCase())</span> <span style="color: #d0d0d0">!==</span> <span style="color: #d0d0d0">-</span><span style="color: #3677a9">1</span><span style="color: #d0d0d0">;</span>
    <span style="color: #d0d0d0">});</span>
    <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.setState({items:</span> <span style="color: #d0d0d0">updatedList});</span>
  <span style="color: #d0d0d0">},</span>
  <span style="color: #d0d0d0">getInitialState:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
     <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">{</span>
       <span style="color: #d0d0d0">initialItems:</span> <span style="color: #d0d0d0">[</span>
         <span style="color: #ed9d13">"Apples"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Broccoli"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Chicken"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Duck"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Eggs"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Fish"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Granola"</span><span style="color: #d0d0d0">,</span>
         <span style="color: #ed9d13">"Hash Browns"</span>
       <span style="color: #d0d0d0">],</span>
       <span style="color: #d0d0d0">items:</span> <span style="color: #d0d0d0">[]</span>
     <span style="color: #d0d0d0">}</span>
  <span style="color: #d0d0d0">},</span>
  <span style="color: #d0d0d0">componentWillMount:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
    <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.setState({items:</span> <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.initialItems})</span>
  <span style="color: #d0d0d0">},</span>
  <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
    <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
      <span style="color: #d0d0d0">&lt;div</span> <span style="color: #d0d0d0">className=</span><span style="color: #ed9d13">"filter-list"</span><span style="color: #d0d0d0">&gt;</span>
        <span style="color: #d0d0d0">&lt;input</span> <span style="color: #d0d0d0">type=</span><span style="color: #ed9d13">"text"</span> <span style="color: #d0d0d0">placeholder=</span><span style="color: #ed9d13">"Search"</span> <span style="color: #d0d0d0">onChange={</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.filterList}/&gt;</span>
      <span style="color: #d0d0d0">&lt;List</span> <span style="color: #d0d0d0">items={</span><span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.state.items}/&gt;</span>
      <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/div&gt;</span>
    <span style="color: #d0d0d0">);</span>
  <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span></p>

<p><span style="color: #6ab825; font-weight: bold">var</span> <span style="color: #d0d0d0">List</span> <span style="color: #d0d0d0">=</span> <span style="color: #d0d0d0">React.createClass({</span> <br>
  <span style="color: #d0d0d0">render:</span> <span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(){</span>
    <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">(</span>
      <span style="color: #d0d0d0">&lt;ul&gt;</span>
      <span style="color: #d0d0d0">{</span>
        <span style="color: #6ab825; font-weight: bold">this</span><span style="color: #d0d0d0">.props.items.map(</span><span style="color: #6ab825; font-weight: bold">function</span><span style="color: #d0d0d0">(item)</span> <span style="color: #d0d0d0">{</span>
          <span style="color: #6ab825; font-weight: bold">return</span> <span style="color: #d0d0d0">&lt;li</span> <span style="color: #d0d0d0">key={item}&gt;{item}&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/li&gt;</span>
        <span style="color: #d0d0d0">})</span>
       <span style="color: #d0d0d0">}</span>
      <span style="color: #d0d0d0">&lt;</span><span style="color: #a61717; background-color: #e3d2d2">/ul&gt;</span>
    <span style="color: #d0d0d0">)</span> <br>
  <span style="color: #d0d0d0">}</span>
<span style="color: #d0d0d0">});</span></p>

<p><span style="color: #d0d0d0">React.render(&lt;FilteredList/&gt;,</span> <span style="color: #24909d">document</span><span style="color: #d0d0d0">.getElementById(</span><span style="color: #ed9d13">'mount-point'</span><span style="color: #d0d0d0">));</span> <br>
</p></pre></div><p></p>
<h3 id="conclusion">Conclusion</h3>
<p>Now that we have reviewed some React basics, take some time to check out the <a href="http://facebook.github.io/react/docs/top-level-api.html">React API</a> and read up a bit on <a href="http://facebook.github.io/react/docs/jsx-in-depth.html">JSX</a>.</p>
<p>stay connect with our <a href="https://www.facebook.com/fourtyonestudio">facebook</a>, <a href"https:="" twitter.com="" 41studio"="">twitter</a> and <a href="https://www.linkedin.com/company/1323325?trk=vsrp_companies_res_name&amp;trkInfo=VSRPsearchId%3A3542812511436513564736%2CVSRPtargetId%3A1323325%2CVSRPcmpt%3Aprimary">linkedin</a></p>

<p>if you have any question, please fill free to ask us using the comment box below</p>


    </article>
