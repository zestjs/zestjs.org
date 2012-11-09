define ['cs!./doc-page/doc-page'], (DocPage) ->
  structure: DocPage
  options:
    title: 'Why Zest?'
    section: 'why-zest'
    data: [
      chapterName: 'Towards a Component Web'
      sections: [
        sectionName: 'The Idea'
        markdown: """
          
          ZestJS grew from a very simple idea:
          
          **The need to write easily installable and buildable components that can be shared between sites.**
          
          Installing should be one command. Requiring should be a one line require. And building should be a single step as well.
          The framework should be minimal, flexible and open, and not impose any way of doing things unnecessarily.
          
          Zest is at its core a specification for such components.
          
          A component is a combination of template HTML, CSS and JavaScript dependencies. It is a template, which takes JSON options data, and returns HTML.
          
          There are many benefits of a component model - code reuse between sites and organisations along with the open source benefits.
          If you can break an entire webpage specification down into components, it's much easier to break down the workload between developers, just like
          Object Oriented programming provides. Testing becomes easier as you can test the individual components separately.
          
          This website itself is built using Zest. Feel free to view the source in the page or on [GitHub here](https://github.com/zestjs/zestjs.org).
        """
      ,
        sectionName: "What's Already Out There"
        markdown: """
          The WCI ([Web Components Initiative](http://dvcs.w3.org/hg/webcomponents/raw-file/tip/explainer/index.html)) is making good strides with new HTML specifications including custom elements and the shadow DOM.
          But full support across browsers and devices is still a long way off. We need something we can use today.
          
          Angular and X-Tag support a basic version of the custom element registration. This allows for custom HTML elements to get turned
          into different HTML when inserted into the page or on a page load. While these also lack comprehensive browser and device support, their compatibility is growing fast. 
          
          It's a nice feature, but it gives the impression of solving the component problems without actually tackling the major ones properly.
          Namely component loading and dependency management with caching and building.
          
          Additionally, we end up writing components in HTML, with data-attributes specifying interactions and script and CSS defined within
          the HTML file, instead of being able to deal with them as JavaScript objects, which is how we typically interact with something
          in JavaScript.
          
          Because we've hidden the internals of our element from the underlying HTML, we're actually hiding content as well.
          This means custom elements are naturally less Google-friendly.
          
          It should be possible for every part of a webpage to be a component, without sacrificing search engine potential.
          A component system should be based on the principles of dependency and build management at its core, as that is the fundamental
          property of being able to share portable code. And it should be possible to use the technology across all devices today, without
          having to work out complicated fallback solutions.
          
        """
      ,
        sectionName: 'Package, Dependency and Build Management'
        markdown: """
          
          The first step is getting the package management, requiring and build support.
          
          In particular there were two major requirements for this:
          
          1. For the package management to automatically include the necessary CSS and resources.
          2. A unified dependency and build process that can understand the components, their dependencies and automatically compile CSS and JavaScripts as necessary.
          
          The best current solution for (2) is AMD, with [RequireJS](http://requirejs.org) the most mature, supported and used implementation.
          
          For (1), there are a few options for this at the moment. For our criterias, [Volo](http://volojs.org) was chosen as it is naturally compatible with RequireJS, with the same proven support level.
          
          There is no reason another package manager couldn't be used with Zest, or another AMD loader for that matter.
          
        """
      ,
        sectionName: 'The Natural Development and Production Environments with AMD'
        markdown: """
          
          Another benefit provided by AMD is that it allows very natural development and production environments.
          
          In development, all dependencies are loaded by the browser. There is no build step. This facilitates a very quick reload time between changes, which
          creates a fast feedback cycle for development work, which is such an important thing for the prototyping phase.
          
          Even compiled resources such as CoffeeScript or LESS are downloaded and compiled by the browser. This means only the absolutely necessary development files for the current page are compiled as needed, saving time.
          
          In production, the dependencies are built into a single script. CoffeeScript gets compiled to JavaScript and LESS to CSS. The development and production environments are designed to behave identically, so that this switch is suprisingly painless.
        """
      ,
        sectionName: 'Modular CSS - Just Another Dependency'
        markdown: """
          
          The first problem is to manage CSS as another dependency compatible with the natural build process provided by RequireJS.
          
          [RequireCSS](https://github.com/guybedford/require-css) solves this problem.
          
          It allows CSS dependencies just like JS dependencies. **The CSS is a dependency of the script that renders the template.** If I render a dynamic slideshow on the browser, the slideshow CSS is a dependency of the slideshow renderer.
          
          For example, we might write our slideshow in AMD as:
          
          slideshow-render.js:
          ```javascript
            define([
              'jade!./slideshowTemplate',
              'css!./slideshowStyle'
            ], function(slideshowTemplate) {
              return slideshowTemplate;
            });
          ```
          
          The above code would load the separate 'slideshowTemplate.jade' and 'slideshowStyle.css' files.
          The [jade! plugin](https://github.com/rocketlabsdev/require-jade) returns the compiled template function here.
          So we simply need to run that function with the template options in order to get our rendered HTML.
          
          Additionally, we've already supported our build, because the Jade plugin will automatically provide the compiled template function
          when running the r.js optimizer.
            
          The css! plugin loads the CSS into the page as part of the natural requiring process. So before we've even compiled our template,
          merely by virtue of the fact that we've loaded this code, the CSS is already there waiting to apply. When built, RequireCSS applies the
          same technique, by inlining the CSS (optimizing it in the process) into the built script. It is then automatically injected on load.
          
          This means instead of a script and a link tag, we can have one script tag saving a browser request. If the idea of loading CSS through
          a script tag is hard to accept, there is also an option to output the CSS separately for each separate build layer, fully compatible with [build layer exclusions](http://requirejs.org/docs/1.0/docs/faq-optimization.html#priority).
          
          So to use the above template, we simply need to do:
          
          ```javascript
            require(['slideshow-render'], function(slideshowRender) {
              document.querySelector('#slideshow-container')
                .innerHTML = slideshowRender({options});
            });
          ```
          
          And there we have a completely modular component, that completely supports builds naturally.
          
          This is the basic concept that grew into the Zest component specification.
        """
      ,
        sectionName: "Client or Server?"
        markdown: """
          
          We've been assuming this rendering is happening in the browser. But what about rendering components on the server?
          
          Well it's actually quite straightforward, since AMD runs on the server just as well. Having rendered the HTML, we simply need to supply it to the client.
          For example in NodeJS we could do:
          
          ```javascript
            require(['slideshow'], function(slideshow) {
              res.write(slideshow({options}));
            });
          ```
          
          **We can write a component once, and then use it interchangably between the client and the server.**
          
          We started creating the system with the lowest common denominator in mind (the browser) and have generalised to the server.
          
          #### Handling CSS dependencies for server rendering
          
          This is where the server needs to be a bit more intelligent and carefully detect CSS dependencies for the page and then outputting them
          as necessary.
          
          RequireJS provides a full API for detecting dependency trees, allowing for the CSS dependencies to be derived and injected suitably.
          
          Zest-server grew primarily to serve this need.
        """
      ,
        sectionName: "Dynamic Components: Attachment"
        markdown: """
          We're finally ready to make the slideshow component tick.
          
          We can break the component down into two parts: a render phase, and an attach phase.
          
          We've just discussed the rendering - it runs both on the client and server, generating the template and CSS as above.
          
          Attachment runs only on the client and has its own set of dependencies. Think of a standard jQuery domReady function.
          
          So let's look at the attachment for this slideshow (assuming a jQuery plugin doing the work, jquery.slideshow.js):
          
          slideshow-attach.js:
          ```javascript
            define([
              'jquery',
              'jquery.slideshow'
            ], function($) {
              return function(attachContext, options) {
                $('.slideshow', attachContext).slideshow(options);
              }
            });
          ```
          
          The attachment function takes two arguments: the HTML context for attachment, and the options for attachment (which are separate to our rendering options).
          
          So lets combine the above techniques in a browser rendering example:
          
          ```javascript
            require([
              'slideshow-render',
              'slideshow-attach'
            ], function(slideshowRender, slideshowAttach) {
              var slideshowContainer = document.querySelector('#slideshow-container');
              
              slideshowContainer.innerHTML = slideshow({renderOptions});
              slideshowAttach(slideshowContainer, {attachOptions});
            });
          ```
          
          Lovely.
          
          Notice also how easy it is to convert an existing jQuery plugin into a fully-portable component.
          
          But we're already repeating ourselves. The above code is the same for every component. What we've hit on here is the need for a general
          render function that can handle this for us.
          
          Some extra features come to mind:
          * Why do we need to create the attach options? Surely these can also be put together by the component itself?
          * How can we have components contain other components in regions?
          * What about asynchronous component loading and how does this all also happen on the server identically?
          * How do we handle component extension and inheritance?
          
        """
      ,
        sectionName: "Component Specification"
        markdown: """
          
          `zest.render` implements the component specification on both the client and the server equally.
          
          zest-server provides the component rendering for NodeJS. Alternatively it can act as a service application providing a 'render service' for other frameworks.
          zest-client provides the component rendering in the browser.
          
          zest.render takes the following form:
          
          ```javascript
            zest.render(renderable, options, destination)
          ```
          
          * **renderable**: _The object to be rendered. Confirming to the Zest render specification_
          * **options** (optional): _The rendering options object_
          * **destination**: _On the client, it's a containing elemenet. On the server it's the response object to render and HTML string_
          
          [The full specification is available here](/docs/zest-client#$z.render)
          
          Then the Component renderable is described by an object with the following properties:
          
          ```javascript
            {
              //default options object, to be populated when not given
              options: {},
              
              //load function. Synchronous and asynchronous forms allowed (done as an optional argument).
              load: function(options, done) {},
              
              //template function or direct string
              template: function(options) {},
              
              //pipe -> converts the 'render' options into 'attach' options for use on the client
              pipe: function(options) {
                return {
                  attach: 'options'
                };
              },
              
              //attachment -> the module Id to use for the attachment of this component.
              attach: 'moduleId'
            }
          ```
          
          
          A renderable can be one of the following five forms:
          * **moduleId, string**: A string specifying the RequireJS moduleId for the renderable.
          * **[renderables], Array**: An array of renderables. When used with options, the options are ignored.
          * **function**: A function returning a renderable. For example, this allows for dynamic region population.
          * **Instance Render, Object**: It can be necessary to define a renderable with options set. The instance render takes the form:
            ```javascript
              {
                structure: renderable,
                options: {options}
              }
            ```
            This render is detected by the existence of a `structure` attribute.
          * **Component Render, Object**: The component specification. Detected by the existence of a `template` attribute, with first preference over other renderable detection.
          
        """
      ,
        sectionName: "Next Steps"
        markdown: """
          Get started with Zest in either the browser or the server by following [the instructions on the getting started page](/start).
          
          Engage with us on [Google groups](http://groups.google.com/group/zestjs), or [Github](https://github.com/zestjs).
          
          Suggestions, feedback and comments welcome!
        """
      ]
    ]
