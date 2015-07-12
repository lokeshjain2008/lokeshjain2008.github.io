---
layout: post
date: "Sat Jul 11 22:07:07 2015"
comments: true
title: "CSS3 animation for the beginners"
---
<div class="post-body" style="position: relative;"><div class="carnival"></div>
<div id="ThbBot-indicator" data-indicator-for="ThbBot" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="ThbBot">The human brain is hardwired to pay attention to moving objects. Because of this
natural reflex to notice movement, adding animation to your website or app is a
powerful way to draw users attention to important areas of your product and add
interest to your interface.</p>

<div id="WdwIft-indicator" data-indicator-for="WdwIft" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="WdwIft">When done well, animations can add valuable interaction and feedback, as well as
enhance the emotional experience, bring delight, and add personality to your
interface. In fact, <em>to animate</em> means <em>to bring to life.</em></p>

<blockquote>
<p>Emotional design’s primary goal is to facilitate human-to-human communication.
If we’re doing our job well, the computer recedes into the background, and
personalities rise to the surface.</p>
</blockquote>

<div id="AWDAWD-indicator" data-indicator-for="AWDAWD" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="AWDAWD"><cite>Aarron Walter, Designing For Emotion</cite></p>

<div id="ItpYcf-indicator" data-indicator-for="ItpYcf" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="ItpYcf">In this post we’re going to walk through the basics of <abbr title="Cascading
Style Sheets">CSS</abbr>
 animation. You can <a href="http://codepen.io/collection/nbEZgX/">follow along and view the CSS
code</a> for the example animations in this
post.</p>
###There some more links to follow for the css values and animations
- This block has amazing knowledge for the css animations [http://keithclark.co.uk](http://keithclark.co.uk)
- Read this blog for the amazing CSS only parallax effect [blog](http://keithclark.co.uk/articles/pure-css-parallax-websites/)
- There is one more link for the parallax effect that is not correct but still this is somewhat ok
  [link](http://davidwalsh.name/parallax)
- 5 HTML API to use now, `classlist`, `context menu`, `element.dataset` [link](http://davidwalsh.name/html5-apis)
- Some CSS properties for more CSS/mobile support.
   - user-select: none;
   - Deep-linking in the mobile for better links
   - Html Attributes
     - accesskey for the keyboard shortcuts
     - spellcheck for the spelling checking support in the browsers.
- HTML and other standards
  - prefetch <link rel="prefetch" href="http://davidwalsh.name/wp-content/themes/walshbook3/images/sprite.png" />
  - FullScreen api
  - page-visibility api - [link](http://davidwalsh.name/page-visibility)
  - `-webkit-touch-callout` - [link](https://developer.mozilla.org/en-US/docs/Web/CSS/-webkit-touch-callout)
  - `Web API reference` [link](https://developer.mozilla.org/en-US/docs/Web/Reference/API)
  - `Guide to Web APIs` Now There are more to learn like File System api, Camera API, Gamepad API and vibration api [link](https://developer.mozilla.org/en-US/docs/Web/Guide/API)
  - Using the application cache and manifest file [link](https://developer.mozilla.org/en-US/docs/Web/HTML/Using_the_application_cache)
  - There is more for your dom called `WebComponents` (They have their own css and js) [link](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and [blog](http://component.kitchen/tutorial)
  -


<h2 id="the-building-blocks-of-animations">The Building Blocks of Animations</h2>

<div id="CaaCaa-indicator" data-indicator-for="CaaCaa" class="carnival-comment-indicator"></div><p id="CaaCaa">CSS animations are made up of two basic building blocks.</p>

<ol>
<li><strong>Keyframes</strong> - define the stages and styles of the animation.</li>
<li><strong>Animation Properties</strong> - assign the @keyframes to a specific CSS element
and define <em>how</em> it is animated.</li>
</ol>

<div id="LlaLla-indicator" data-indicator-for="LlaLla" class="carnival-comment-indicator"></div><p id="LlaLla">Let’s look at each individually.</p>

<h2 id="building-block-#1:-keyframes">Building Block #1: Keyframes</h2>

<div id="KatEki-indicator" data-indicator-for="KatEki" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="KatEki">Keyframes are the foundation of <abbr title="Cascading Style Sheets">CSS</abbr>
animations. They define what the animation looks like at each stage of the
animation timeline. Each <code>@keyframes</code> is composed of:</p>

<ul>
<li><strong>Name of the animation:</strong> A name that describes the animation, for example,
<code>bounceIn</code>.</li>
<li><strong>Stages of the animation:</strong> Each stage of the animation is represented as a
percentage.  <code>0%</code> represents the beginning state of the animation. <code>100%</code>
represents the ending state of the animation. Multiple intermediate states can
be added in between.</li>
<li><strong>CSS Properties:</strong> The CSS properties defined for each stage of the animation
timeline.</li>
</ul>

<div id="LtaAtf-indicator" data-indicator-for="LtaAtf" class="carnival-comment-indicator"></div><p id="LtaAtf">Let’s take a look at a simple <code>@keyframes</code> I’ve named “bounceIn”. This
<code>@keyframes</code> has three stages. At the first stage <code>(0%)</code>, the element is at
opacity 0 and scaled down to 10 percent of its default size, using CSS transform
scale. At the second stage <code>(60%)</code> the element fades in to full opacity and
grows to 120 percent of its default size. At the final stage <code>(100%)</code>, it scales
down slightly and returns to its default size.</p>

<div id="TkaTka-indicator" data-indicator-for="TkaTka" class="carnival-comment-indicator"></div><p id="TkaTka">The <code>@keyframes</code> are added to your main CSS file.</p>

<div id="kbtots-indicator" data-indicator-for="kbtots" class="carnival-comment-indicator"></div><pre id="kbtots"><code class="css hljs"><span class="at_rule">@<span class="keyword">keyframes</span> bounceIn </span>{
  0% <span class="rules">{
    <span class="rule"><span class="attribute">transform</span>:<span class="value"> <span class="function">scale</span>(<span class="number">0.1</span>)</span></span>;
    <span class="rule"><span class="attribute">opacity</span>:<span class="value"> <span class="number">0</span></span></span>;
  <span class="rule">}</span></span>
  60% <span class="rules">{
    <span class="rule"><span class="attribute">transform</span>:<span class="value"> <span class="function">scale</span>(<span class="number">1.2</span>)</span></span>;
    <span class="rule"><span class="attribute">opacity</span>:<span class="value"> <span class="number">1</span></span></span>;
  <span class="rule">}</span></span>
  100% <span class="rules">{
    <span class="rule"><span class="attribute">transform</span>:<span class="value"> <span class="function">scale</span>(<span class="number">1</span>)</span></span>;
  <span class="rule">}</span></span>
}
</code></pre>

<div id="IyuCCt-indicator" data-indicator-for="IyuCCt" class="carnival-comment-indicator"></div><p id="IyuCCt">(If you’re unfamiliar with CSS Transforms, you’ll want to <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/transform">brush up on your
knowledge.</a>
Combining CSS transforms in the animations is really where the magic happens.)</p>

<h2 id="building-block-#2:-animation-properties">Building Block #2: Animation Properties</h2>

<div id="OtkOtk-indicator" data-indicator-for="OtkOtk" class="carnival-comment-indicator"></div><p id="OtkOtk">Once the <code>@keyframes</code> are defined, the animation properties must be added in order
for your animation to function.</p>

<div id="ApdApd-indicator" data-indicator-for="ApdApd" class="carnival-comment-indicator"></div><p id="ApdApd">Animation properties do two things:</p>

<ol>
<li>They assign the <code>@keyframes</code> to the elements that you want to animate.</li>
<li>They define <em>how</em> it is animated.</li>
</ol>

<div id="TapYma-indicator" data-indicator-for="TapYma" class="carnival-comment-indicator"></div><p id="TapYma">The animation properties are added to the CSS selectors (or elements) that you
want to animate. You must add the following two animation
properties for the animation to take effect:</p>

<ul>
<li><code>animation-name</code>: The name of the animation, defined in the <code>@keyframes</code>.</li>
<li><code>animation-duration</code>: The duration of the animation, in seconds (e.g., 5s)
or milliseconds (e.g., 200ms).</li>
</ul>

<div id="CwtCwt-indicator" data-indicator-for="CwtCwt" class="carnival-comment-indicator"></div><p id="CwtCwt">Continuing with the above <code>bounceIn</code> example, we’ll add <code>animation-name</code> and
<code>animation-duration</code> to the div that we want to animate.</p>

<div id="dasdas-indicator" data-indicator-for="dasdas" class="carnival-comment-indicator" style="opacity: 0;"></div><pre id="dasdas"><code class="css hljs"><span class="tag">div</span> <span class="rules">{
  <span class="rule"><span class="attribute">animation-duration</span>:<span class="value"> <span class="number">2s</span></span></span>;
  <span class="rule"><span class="attribute">animation-name</span>:<span class="value"> bounceIn</span></span>;
<span class="rule">}</span></span>
</code></pre>

<div id="SsSs-indicator" data-indicator-for="SsSs" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="SsSs">Shorthand syntax:</p>

<div id="dabdab-indicator" data-indicator-for="dabdab" class="carnival-comment-indicator" style="opacity: 0;"></div><pre id="dabdab"><code class="css hljs"><span class="tag">div</span> <span class="rules">{
  <span class="rule"><span class="attribute">animation</span>:<span class="value"> bounceIn <span class="number">2s</span></span></span>;
<span class="rule">}</span></span>
</code></pre>

<div id="BabBab-indicator" data-indicator-for="BabBab" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="BabBab">By adding both the @keyframes and the animation properties, we have a simple animation!</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationbounceIngif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationbounceIngif" class="carnival-comment-indicator" style="opacity: 1;"><span class="carnival-count">1</span></div><p id="httpsimagesthoughtbotcombloganimationsanimationbounceIngif"><img src="https://images.thoughtbot.com/blog+animations/animation-bounceIn.gif" alt="example"></p>

<h2 id="animation-property-shorthand">Animation Property Shorthand</h2>

<div id="EapAta-indicator" data-indicator-for="EapAta" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="EapAta">Each animation property can be defined individually, but for cleaner and faster
code, it’s recommended that you use the animation shorthand. All the animation
properties are added to the same <code>animation:</code> property in the following order:</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="css hljs"><span class="tag">animation</span>: <span class="attr_selector">[animation-name]</span> <span class="attr_selector">[animation-duration]</span> <span class="attr_selector">[animation-timing-function]</span>
<span class="attr_selector">[animation-delay]</span> <span class="attr_selector">[animation-iteration-count]</span> <span class="attr_selector">[animation-direction]</span>
<span class="attr_selector">[animation-fill-mode]</span> <span class="attr_selector">[animation-play-state]</span>;
</code></pre>

<div id="JrfJrf-indicator" data-indicator-for="JrfJrf" class="carnival-comment-indicator"></div><p id="JrfJrf">Just remember for the animation to function correctly, you need to follow the
proper shorthand order AND specify at least the first two values.</p>

<h2 id="note-about-prefixes">Note About Prefixes</h2>

<div id="AolFsI-indicator" data-indicator-for="AolFsI" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="AolFsI">As of late 2014, many Webkit based browsers <a href="http://caniuse.com/#feat=css-animation">still
use</a> the -webkit-prefixed version of
both animations, keyframes, and transitions. Until they adopt the standard
version, you’ll want to include both unprefixed and Webkit versions in your
code. (For simplicity, I’ll only be using the unprefixed versions in my
examples.)</p>

<div id="KaaKaa-indicator" data-indicator-for="KaaKaa" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="KaaKaa">Keyframes and animations with WebKit prefixes:</p>

<div id="dwsdws-indicator" data-indicator-for="dwsdws" class="carnival-comment-indicator" style="opacity: 0;"></div><pre id="dwsdws"><code class="css hljs"><span class="tag">div</span> <span class="rules">{
  <span class="rule"><span class="attribute">-webkit-animation-duration</span>:<span class="value"> <span class="number">2s</span></span></span>;
  <span class="rule"><span class="attribute">animation-duration</span>:<span class="value"> <span class="number">2s</span></span></span>;
  <span class="rule"><span class="attribute">-webkit-animation-name</span>:<span class="value"> bounceIn</span></span>;
  <span class="rule"><span class="attribute">animation-name</span>:<span class="value"> bounceIn</span></span>;
<span class="rule">}</span></span>
</code></pre>

<div id="wbswbs-indicator" data-indicator-for="wbswbs" class="carnival-comment-indicator"></div><pre id="wbswbs"><code class="css hljs"><span class="at_rule">@<span class="keyword">-webkit-keyframes</span> bounceIn </span>{ <span class="comment">/* styles */</span> }
<span class="at_rule">@<span class="keyword">keyframes</span> bounceIn </span>{ <span class="comment">/* styles */</span> }
</code></pre>

<div id="TmyHhs-indicator" data-indicator-for="TmyHhs" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="TmyHhs">To make your life easier, consider using <a href="http://bourbon.io/">Bourbon</a>, a SASS
mixin library which contains up-to-date vendor prefixes for all modern browsers.
Here’s how simple it is to generate vendor-prefixed animations and keyframes
using Bourbon:</p>

<div id="diadia-indicator" data-indicator-for="diadia" class="carnival-comment-indicator" style="opacity: 0;"></div><pre id="diadia"><code class="css hljs"><span class="tag">div</span> <span class="rules">{
  <span class="rule">@<span class="attribute">include animation(bounceIn 2s);
}
</span></span></span></code></pre>

<div id="iksiks-indicator" data-indicator-for="iksiks" class="carnival-comment-indicator" style="opacity: 0;"></div><pre id="iksiks"><code class="css hljs"><span class="at_rule">@<span class="keyword">include</span> <span class="function">keyframes</span>(bouncein) </span>{ <span class="comment">/* styles */</span>}
</code></pre>

<h2 id="additional-animation-properties">Additional Animation Properties</h2>

<div id="IatIat-indicator" data-indicator-for="IatIat" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="IatIat">In addition to the required <strong>animation-name</strong> and <strong>animation-duration</strong>
properties, you can further customize and create complex animations using the
following properties:</p>

<ul>
<li><code>animation-timing-function</code></li>
<li><code>animation-delay</code></li>
<li><code>animation-iteration-count</code></li>
<li><code>animation-direction</code></li>
<li><code>animation-fill-mode</code></li>
<li><code>animation-play-state</code></li>
</ul>

<div id="LlaLla-indicator" data-indicator-for="LlaLla" class="carnival-comment-indicator"></div><p id="LlaLla">Let’s look at each of them individually.</p>

<h2 id="animation-timing-function">Animation-timing-function</h2>

<div id="TadOfm-indicator" data-indicator-for="TadOfm" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="TadOfm">The <code>animation-timing-function:</code> defines the speed curve or pace of the
animation. You can specify the timing with the following predefined timing
options: <code>ease</code>, <code>linear</code>, <code>ease-in</code>, <code>ease-out</code>, <code>ease-in-out</code>, <code>initial</code>,
<code>inherit</code>. (Or for more advanced timing options, you can creating custom timing
functions using <a href="https://developer.mozilla.org/en-US/docs/Web/CSS/timing-function">cubic-bezier
curve</a>.)</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationtiminggif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationtiminggif" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="httpsimagesthoughtbotcombloganimationsanimationtiminggif"><img src="https://images.thoughtbot.com/blog+animations/animation-timing.gif" alt="example"></p>

<div id="TdvYcr-indicator" data-indicator-for="TdvYcr" class="carnival-comment-indicator" style="opacity: 0;"></div><p id="TdvYcr">The default value, if no other value is assigned, is <code>ease</code>, which starts out
slow, speeds up, then slows down. You can read a description of each timing
function
<a href="http://www.w3schools.com/cssref/css3_pr_animation-timing-function.asp">here</a>.</p>

<div id="CsCs-indicator" data-indicator-for="CsCs" class="carnival-comment-indicator"></div><p id="CsCs">CSS syntax:</p>

<div id="aeae-indicator" data-indicator-for="aeae" class="carnival-comment-indicator"></div><pre id="aeae"><code class="css hljs"><span class="tag">animation-timing-function</span>: <span class="tag">ease-in-out</span>;
</code></pre>

<div id="AssAss-indicator" data-indicator-for="AssAss" class="carnival-comment-indicator"></div><p id="AssAss">Animation shorthand syntax (recommended):</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="css hljs"><span class="tag">animation</span>: <span class="attr_selector">[animation-name]</span> <span class="attr_selector">[animation-duration]</span> <span class="attr_selector">[animation-timing-function]</span>;
<span class="tag">animation</span>: <span class="tag">bounceIn</span> 2<span class="tag">s</span> <span class="tag">ease-in-out</span>;
</code></pre>

<h2 id="animation-delay">Animation-Delay</h2>

<div id="TaaAnv-indicator" data-indicator-for="TaaAnv" class="carnival-comment-indicator"></div><p id="TaaAnv">The <code>animation-delay:</code> allows you to specify when the animation (or pieces of
the animation) will start. A positive value (such as 2s) will start the
animation 2 seconds after it is triggered. The element will remain unanimated
until that time.  A negative value (such as -2s) will start the animation at
once, but starts 2 seconds into the animation.</p>

<div id="TviTvi-indicator" data-indicator-for="TviTvi" class="carnival-comment-indicator"></div><p id="TviTvi">The value is defined in seconds (s) or milliseconds (mil).</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationdelaygif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationdelaygif" class="carnival-comment-indicator"></div><p id="httpsimagesthoughtbotcombloganimationsanimationdelaygif"><img src="https://images.thoughtbot.com/blog+animations/animation-delay.gif" alt="example"></p>

<div id="CsCs-indicator" data-indicator-for="CsCs" class="carnival-comment-indicator"></div><p id="CsCs">CSS syntax:</p>

<div id="asas-indicator" data-indicator-for="asas" class="carnival-comment-indicator"></div><pre id="asas"><code class="css hljs"><span class="tag">animation-delay</span>: 5<span class="tag">s</span>;
</code></pre>

<div id="AssAss-indicator" data-indicator-for="AssAss" class="carnival-comment-indicator"></div><p id="AssAss">Animation shorthand syntax (recommended):</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="css hljs"><span class="tag">animation</span>: <span class="attr_selector">[animation-name]</span> <span class="attr_selector">[animation-duration]</span> <span class="attr_selector">[animation-timing-function]</span>
<span class="attr_selector">[animation-delay]</span>;
<span class="tag">animation</span>:  <span class="tag">bounceIn</span> 2<span class="tag">s</span> <span class="tag">ease-in-out</span> 3<span class="tag">s</span>;
</code></pre>

<h2 id="animation-iteration-count">Animation-iteration-count</h2>

<div id="TasTpv-indicator" data-indicator-for="TasTpv" class="carnival-comment-indicator"></div><p id="TasTpv">The <code>animation-iteration-count:</code> specifies the number of times that the animation
will play. The possible values are:</p>

<div id="asnasn-indicator" data-indicator-for="asnasn" class="carnival-comment-indicator"></div><p id="asnasn"><code>#</code>- a specific number of iterations (default is <code>1</code>)</p>

<div id="itaita-indicator" data-indicator-for="itaita" class="carnival-comment-indicator"></div><p id="itaita"><code>infinite</code>   - the animation repeats forever</p>

<div id="istist-indicator" data-indicator-for="istist" class="carnival-comment-indicator"></div><p id="istist"><code>initial</code> - sets the iteration count to the default value</p>

<div id="iitiit-indicator" data-indicator-for="iitiit" class="carnival-comment-indicator"></div><p id="iitiit"><code>inherit</code> - inherits the value from the parent</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationiterationgif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationiterationgif" class="carnival-comment-indicator"></div><p id="httpsimagesthoughtbotcombloganimationsanimationiterationgif"><img src="https://images.thoughtbot.com/blog+animations/animation-iteration.gif" alt="example"></p>

<div id="CsCs-indicator" data-indicator-for="CsCs" class="carnival-comment-indicator"></div><p id="CsCs">CSS syntax:</p>

<div id="aa-indicator" data-indicator-for="aa" class="carnival-comment-indicator"></div><pre id="aa"><code class="css hljs"><span class="tag">animation-iteration-count</span>: 2;
</code></pre>

<div id="AssAss-indicator" data-indicator-for="AssAss" class="carnival-comment-indicator"></div><p id="AssAss">Animation shorthand syntax (recommended):</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="hljs">animation: [animation-name] [animation-duration] [animation-timing-function]
[animation-delay] [animation-iteration-count];
animation:  bounceIn 2s ease-in-out 3s 2;
</code></pre>

<h2 id="animation-direction">Animation-direction</h2>

<div id="TapTap-indicator" data-indicator-for="TapTap" class="carnival-comment-indicator"></div><p id="TapTap">The <code>animation-direction:</code> property specifies whether the animation should play
forward, reverse, or in alternate cycles.</p>

<div id="TpvTpv-indicator" data-indicator-for="TpvTpv" class="carnival-comment-indicator"></div><p id="TpvTpv">The possible values are:</p>

<div id="ndTOec-indicator" data-indicator-for="ndTOec" class="carnival-comment-indicator"></div><p id="ndTOec"><code>normal</code> (default) - The animation plays forward. On each cycle the animation
resets to the beginning state (0%) and plays forward again (to 100%).</p>

<div id="rTaOec-indicator" data-indicator-for="rTaOec" class="carnival-comment-indicator"></div><p id="rTaOec"><code>reverse</code> - The animation plays backwards. On each cycle the animation resets
to the end state (100%) and plays backwards (to 0%).</p>

<div id="aTaOee-indicator" data-indicator-for="aTaOee" class="carnival-comment-indicator"></div><p id="aTaOee"><code>alternate</code> - The animation reverses direction every cycle. On each odd cycle,
the animation plays forward (0% to 100%). On each even cycle, the animation
plays backwards (100% to 0%).</p>

<div id="aTaOee-indicator" data-indicator-for="aTaOee" class="carnival-comment-indicator"></div><p id="aTaOee"><code>alternate-reverse</code> - The animation reverses direction every cycle. On each
odd cycle, the animation plays in reverse (100% to 0%). On each even cycle, the
animation plays forward (0% or 100%).</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationdirectiongif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationdirectiongif" class="carnival-comment-indicator"></div><p id="httpsimagesthoughtbotcombloganimationsanimationdirectiongif"><img src="https://images.thoughtbot.com/blog+animations/animation-direction.gif" alt="example"></p>

<div id="CsCs-indicator" data-indicator-for="CsCs" class="carnival-comment-indicator"></div><p id="CsCs">CSS syntax:</p>

<div id="aaaa-indicator" data-indicator-for="aaaa" class="carnival-comment-indicator"></div><pre id="aaaa"><code class="css hljs"><span class="tag">animation-direction</span>: <span class="tag">alternate</span>;
</code></pre>

<div id="AssAss-indicator" data-indicator-for="AssAss" class="carnival-comment-indicator"></div><p id="AssAss">Animation shorthand syntax (recommended):</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="css hljs"><span class="tag">animation</span>: <span class="attr_selector">[animation-name]</span> <span class="attr_selector">[animation-duration]</span> <span class="attr_selector">[animation-timing-function]</span>
<span class="attr_selector">[animation-delay]</span> <span class="attr_selector">[animation-iteration-count]</span> <span class="attr_selector">[animation-direction]</span>;
<span class="tag">animation</span>:  <span class="tag">bounceIn</span> 2<span class="tag">s</span> <span class="tag">ease-in-out</span> 3<span class="tag">s</span> 3 <span class="tag">alternate</span>;
</code></pre>

<h2 id="animation-fill-mode">Animation-fill-mode</h2>

<div id="TasTpi-indicator" data-indicator-for="TasTpi" class="carnival-comment-indicator"></div><p id="TasTpi">The <code>animation-fill-mode:</code> specifies if the animation styles are visible before
or after the animation plays. This property is a little confusing, but once
understood it is very useful.</p>

<div id="BdtTap-indicator" data-indicator-for="BdtTap" class="carnival-comment-indicator"></div><p id="BdtTap">By default, the animation will not effect the styles of the element before the
animation begins (if there is an animation-delay) or after the animation is
finished. The <code>animation-fill-mode</code> property can override this behavior with the
following possible values:</p>

<div id="bBtbBt-indicator" data-indicator-for="bBtbBt" class="carnival-comment-indicator"></div><p id="bBtbBt"><code>backwards</code> - Before the animation (during the animation delay), the styles
of the initial keyframe (0%) are applied to the element.</p>

<div id="fAtfAt-indicator" data-indicator-for="fAtfAt" class="carnival-comment-indicator"></div><p id="fAtfAt"><code>forwards</code> - After the animation is finished, the styles defined in the final
keyframe (100%) are retained by the element.</p>

<div id="bTabTa-indicator" data-indicator-for="bTabTa" class="carnival-comment-indicator"></div><p id="bTabTa"><code>both</code> - The animation will follow the rules for both forwards and backwards,
extending the animation properties before and after the animation.</p>

<div id="ndTndT-indicator" data-indicator-for="ndTndT" class="carnival-comment-indicator"></div><p id="ndTndT"><code>normal</code> (default) - The animation does not apply any styles to the element,
before or after the animation.</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationfillgif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationfillgif" class="carnival-comment-indicator"></div><p id="httpsimagesthoughtbotcombloganimationsanimationfillgif"><img src="https://images.thoughtbot.com/blog+animations/animation-fill.gif" alt="example"></p>

<div id="CsCs-indicator" data-indicator-for="CsCs" class="carnival-comment-indicator"></div><p id="CsCs">CSS syntax:</p>

<div id="afaf-indicator" data-indicator-for="afaf" class="carnival-comment-indicator"></div><pre id="afaf"><code class="css hljs"><span class="tag">animation-fill-mode</span>: <span class="tag">forwards</span>;
</code></pre>

<div id="AssAss-indicator" data-indicator-for="AssAss" class="carnival-comment-indicator"></div><p id="AssAss">Animation shorthand syntax (recommended):</p>

<div id="aaaaaa-indicator" data-indicator-for="aaaaaa" class="carnival-comment-indicator"></div><pre id="aaaaaa"><code class="css hljs"><span class="tag">animation</span>: <span class="attr_selector">[animation-name]</span> <span class="attr_selector">[animation-duration]</span> <span class="attr_selector">[animation-timing-function]</span>
<span class="attr_selector">[animation-delay]</span> <span class="attr_selector">[animation-iteration-count]</span> <span class="attr_selector">[animation-direction]</span>
<span class="attr_selector">[animation-fill-mode]</span>;
<span class="tag">animation</span>:  <span class="tag">bounceIn</span> 2<span class="tag">s</span> <span class="tag">ease-in-out</span> 3<span class="tag">s</span> 3 <span class="tag">forwards</span>;
</code></pre>

<h2 id="animation-play-state">Animation-play-state</h2>

<div id="TasRap-indicator" data-indicator-for="TasRap" class="carnival-comment-indicator"></div><p id="TasRap">The <code>animation-play-state:</code> specifies whether the animation is playing or
paused. Resuming a paused animation starts the animation where it was left off.</p>

<div id="TpvTpv-indicator" data-indicator-for="TpvTpv" class="carnival-comment-indicator"></div><p id="TpvTpv">The possible values are:</p>

<div id="pTapTa-indicator" data-indicator-for="pTapTa" class="carnival-comment-indicator"></div><p id="pTapTa"><code>playing</code> -  The animation is currently running</p>

<div id="pTapTa-indicator" data-indicator-for="pTapTa" class="carnival-comment-indicator"></div><p id="pTapTa"><code>paused</code> - The animation is currently paused</p>

<div id="httpsimagesthoughtbotcombloganimationsanimationplaygif-indicator" data-indicator-for="httpsimagesthoughtbotcombloganimationsanimationplaygif" class="carnival-comment-indicator"></div><p id="httpsimagesthoughtbotcombloganimationsanimationplaygif"><img src="https://images.thoughtbot.com/blog+animations/animation-play.gif" alt="example"></p>

<div id="EE-indicator" data-indicator-for="EE" class="carnival-comment-indicator"></div><p id="EE">Example :</p>

<div id=".ap.ap-indicator" data-indicator-for=".ap.ap" class="carnival-comment-indicator"></div><pre id=".ap.ap"><code class="css hljs"><span class="class">.div</span><span class="pseudo">:hover</span> <span class="rules">{
  <span class="rule"><span class="attribute">animation-play-state</span>:<span class="value"> paused</span></span>;
<span class="rule">}</span></span>
</code></pre>

<h2 id="multiple-animations">Multiple Animations</h2>

<div id="TamHae-indicator" data-indicator-for="TamHae" class="carnival-comment-indicator"></div><p id="TamHae">To add multiple animations to a selector, you simply separate the values with a
comma. Here’s an example:</p>

<div id=".as.as-indicator" data-indicator-for=".as.as" class="carnival-comment-indicator" style="opacity: 1;"><span class="carnival-count">2</span></div><pre id=".as.as"><code class="css hljs"><span class="class">.div</span> <span class="rules">{
  <span class="rule"><span class="attribute">animation</span>:<span class="value"> slideIn <span class="number">2s</span>, rotate <span class="number">1.75s</span></span></span>;
<span class="rule">}</span></span>
</code></pre>

<h2 id="go-forth-and-animate">Go Forth and Animate</h2>

<div id="TiWTbw-indicator" data-indicator-for="TiWTbw" class="carnival-comment-indicator" style="opacity: 1;"><span class="carnival-count">1</span></div><p id="TiWTbw">That’s it! With those basic properties, the possible animations you can create
are endless. The best way learn is to jump in and start animating.</p>

<div id="HaaHaa-indicator" data-indicator-for="HaaHaa" class="carnival-comment-indicator"></div><p id="HaaHaa">Here are a couple of resources to get you started:</p>

<div id="UfDUfD-indicator" data-indicator-for="UfDUfD" class="carnival-comment-indicator"></div><p id="UfDUfD"><strong><a href="https://upcase.com/design/resources?utm_source=blog">Upcase for Designers</a></strong>
- an online learning community with courses on CSS animation, CSS transforms,
and other front-end design and development techniques.</p>

<div id="CaCCaC-indicator" data-indicator-for="CaCCaC" class="carnival-comment-indicator"></div><p id="CaCCaC"><strong><a href="http://codepen.io">CodePen</a></strong> - a CSS playground where you can edit your code
and immediately see your results.</p>

<div id="AalAal-indicator" data-indicator-for="AalAal" class="carnival-comment-indicator"></div><p id="AalAal"><strong><a href="http://daneden.github.io/animate.css/">Animate.css</a></strong> - a library with dozens
of fun animations to get you started and use on your projects.</p>

</div>
