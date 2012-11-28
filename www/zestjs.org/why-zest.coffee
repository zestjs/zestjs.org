define ['cs!./doc-page/doc-page'], (DocPage) ->
  render: DocPage
  options:
    title: 'Why Zest?'
    section: 'why-zest'
    data: [
      chapterName: 'Render Components'
      sections: [
        sectionName: 'The Idea'
        markdown: """
          > This website itself is built using Zest. You can view the source in the page or on [GitHub here](https://github.com/zestjs/zestjs.org).
        
          ZestJS is a collection of tools for building scalable, maintainable modern web applications - both single page applications
          in the browser and multi-page applications with complex interactions.
          
          The key premise of Zest is in making the **Render Component** the unit of development.
          
          A render component is like a jQuery plugin. It consists of an HTML template, CSS style and JavaScript interaction. An example
          would be a slideshow component or even a dropdown menu, static layout or dialog.
          
          There are many benefits to a Render Component model - code reuse between sites and organisations along with the open source
          benefits. If you can break an entire webpage specification down into render components, it's much easier to break down the
          workload between developers. Testing becomes easier as you can isolate separate components easily.
          
          _Zest grew out of the idea that there is a need to write such Render Components in a common format that can be easily installed,
          rendered on both the client and server, built for production and shared between sites, without imposing unnecessary framework
          constraints and leaving the development environment as open and flexible as possible._
          
          Zest at its core is an implementation and specification for these components.
        """
      ,
        sectionName: 'Designing for Many Environments'
        markdown: """
          
          The Render Component specification is designed to work in many scenarios:
          
          * Rendering without a build
          * Rendering with a build
          * Rendering on the client
          * Rendering on the server
          
          [RequireJS](http://requirejs.org) is used for module management. It is based on the AMD module format and supports the
          above environments ideally.
          
          * It runs on both the server and the browser, allowing easy code sharing.
          * It provides build support with the [RequireJS optimizer](http://requirejs.org/docs/optimization.html) allowing
            modules and all their dependencies to be built into a single file with flexible options for script layers.
          * Resources, templates and other assests can be loaded as dependencies just like any other, with build support.
          
          RequireJS also allows very natural production and development environments.
          
          In development, all dependencies are loaded by the browser. There is no build step. This facilitates a very quick reload
          time between changes, which creates a fast feedback cycle for development work. Even compiled resources such as CoffeeScript
          or LESS are downloaded and compiled by the browser.
          This means only the absolutely necessary development files for the current page are compiled as needed, saving time.
          
          In production, the dependencies can be built into a single script. CoffeeScript gets compiled to JavaScript and LESS to CSS,
          which can even be inlined within the script as well. This means instead of a script and a link tag, we can have one script tag
          saving a browser request. If the idea of loading CSS through a script tag is hard to accept, there is also an option to output
          the CSS separately for each separate build layer, fully compatible with
          [build layer exclusions](http://requirejs.org/docs/1.0/docs/faq-optimization.html#priority).
          
          The development and production environments are designed to behave identically, so that this switch is suprisingly painless.
        """
      ,
        
        sectionName: 'Client and Server'
        markdown: """
          
          A Render Component renders based on some render options. For a gallery, it could be a set of image urls. For a menu,
          the menu item names and links.
          
          The render process is broken down into two phases:
          
          1. Rendering the HTML from the options data.
          2. Attaching the dynamic functionality in the browser.
          
        When rendering in the browser, both phases happen together. When rendering on the server, the HTML is generated on the server,
          but the dynamic attachment only happens on the browser.
          
          Zest Server implements the rendering in a NodeJS server. Great care has been taken to ensure this process is as efficient as
          possible. The HTML output is designed so that it is impossible for the HTML to display before the styles have been loaded.
          Also the HTML will not load any further until the dynamic attachment has completed.
          
          While the page is loading, one often sees HTML before it has been given dynamic enhancements. With Zest, if you can see it,
          then the dynamic enhancement has been applied. A gallery will work as soon as it is seen even if the page hasn't completed
          loading.
          
          When building, it is unnecessary to include the render scripts for a component if it will only ever be rendered from the
          server. There is a special build plugin for this, which allows just compiling the code necessary for attachment - the
          dynamic controller, CSS and likewise for any dependencies.
        
        """
      ,
        sectionName: "Dynamic Interaction Architecture"
        markdown: """
          To allow components to communicate with modules and other components, they can define a controller which is simply
          a JavaScript object created during the attachment process. The entire interface is left up to the implementor.
          
          Zest doesn't use MVC. Rather the natural front-end architecture created by Zest is more comporable to a PAC model.
          
          Each component can contain any number of sub components within regions of its template. In this way, components form
          a tree, with the base component at the root.
          
          The idea is that the main parent should only care about the controllers for its direct children and in turn for their children.
          
          This natural modularisation creates a clean architecture. Dynamic information is passed via event listeners from a component
          to its parents. This model is entirely optional though - how you choose to connect the controllers to any model
          implementations is left up to you.
        """
      ,
        sectionName: "The Suggested Way"
        markdown: """
          That said, Zest does provide a suggested way of setting up eventing and component inheritance.
          
          This is referred to as the Zest Object Extension model (ZOE).
          
          At its core it's simply a natural JavaScript inheritance model with eventing. It was designed from the ground up to work with
          Zest Render Components.
          
          It provides a simple implementor, `zoe.Component`, which makes it very easy to define controllers as JavaScript classes
          with events and methods on the prototype. If all components use the same event model, it is obviously much easier for them to
          communicate with eachother.
          
          The inheritance model is provided to allow components to be extensible. An abstract image gallery component could be extended
          by a more specific component, with a specific toolbar and theme, while having their controllers merged by inheritance
          into a single interface to reduce complexity with each inheritor.
        
        """
      ,
        sectionName: "Using Server Rendering"
        markdown: """
        
          Zest Server can be used in a few ways:
          
          1. As an application server consisting of modules, which are mostly route maps from URLs to components.
          2. As a dependency in a NodeJS application to provide rendering when necessary.
          3. As a service, to be integrated with another development environment. It can provide 'rendering as a service'
             over HTTP.
          
          (2) and (3) require the basic RequireJS configurations to be made independently, so there is a little more setup,
          but libraries for other frameworks should be able to support this quite easily in due course.
          
          The application server simply maps route patters to components. The options used for the component rendering are
          derived from the url pattern, with optional processing.
          
          In this way, an entire page can be a component.
          
          Having written a page as a component on the server, it is then simply one line to render that page from the browser
          as well, providing a highly flexible page rendering system - urls will render and support search engines, while
          internal page changes can be rendered locally for maximum speed.
        
        """
      ,
        sectionName: "Loading Data"
        markdown: """
          
          If a page is a component, there are two ways in which component data can be provided:
          
          1. As part of the initial options for the render.
          
            In this model, all of the data for the page is acquired and placed onto a single options object. The page is then
            rendered with these options, with each component passing down the necessary options to its sub components.
          
          2. Locally as part of the loading of each component in the tree.
          
            The other way is through the asynchronous load function for any Render Component. Zest provides a HTTP library which
            provides an identical interface both on the client and server.
            
            This means the component can request its data from a service itself (perhaps with the service URL as an option),
            delaying its rendering until this request has completed.
            
            Since NodeJS is a streaming server, the HTML page stream is optimized around these asynchronous loads for each component.
            Zest Server renders as much as it can, until it hits a component still loading. It then waits for the component to complete,
            while also buffering the rendering of subsequent components.
              
            This also assists towards an optimal page load, as the user could already be interacting with components in the page,
            even before a heavy database request has completed.
          
        """
      ,
        sectionName: "Summary"
        markdown: """
          We've presented a system for defining render components that brings together modular CSS, dependency management, packaging and builds from the core.
          
          The rendering model is based purely on an object interface, the basics of which we've touched upon above.
          
          The additional benefit of an object-based render interface is that this works naturally with JavaScript inheritance.
          
          A custom component inheritance built with this render specification in mind is provided by [$z.Component](), as part of the [zoe inheritance model]().
          
          This has been found to have solved some fundamental architecture issues with large JavaScript applications. The hope is that
          this can benefit others as well as form a part of the dialog for how to approach these problems as web technologies continue to evolve.
        """
      ,
        sectionName: "Next Steps"
        markdown: """
          Get started with Zest in either the browser or the server by following [the instructions on the getting started page](/start).
          
          Dive straight into the rendering guide here.
          
          Engage on [Google groups](http://groups.google.com/group/zestjs), or [Github](https://github.com/zestjs).
          
          Suggestions, feedback and comments welcome!
        """
      ]
    ]
      
###
      ,
        sectionName: "Crap"
        markdown: """
        
          
          
          Zest modularises all of this into one module, which can be shared between sites, rendered on both the client or the server,
          and included in a project build allowing an entire site to contain a single JavaScript file resource.
          
          The portability of Zest Render Components is provided by writing components as AMD modules in RequireJS. This then allows
          builds.
          
          
          
          The key features of Zest are:
          * Supporting package management through AMD.
          * The Zest Render Component specification for modular HTML, JS and CSS pages.
          * The build 
          
          
          
          _A **Render Component** is a combination of template HTML, CSS and JavaScript dependencies. It conforms to an expected interface which specifies a template converting options data into HTML. It also includes a loading hook, CSS, and the dynamic attachment for the HTML. When used with a **render function**, the render component can be rendered into the page as a dynamic component._
          
          Installing should be one command. Requiring should be a one line require. And building should be a single step as well.
          The framework should be minimal, flexible and open, and not impose any way of doing things unnecessarily.
          
          Zest is at its core is an implementation of the specification for such components.
          
          

        
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
          
          It should be possible for every part of a webpage to be a render component, without sacrificing search engine potential.
          A component system should be based on the principles of dependency and build management at its core, as that is a fundamental
          property of being able to share portable code. And it should be possible to use the technology across all devices today, without
          having to work out complicated fallback solutions.
        
        
        
        
          To render components on the server (allowing for multipage apps and search-engine support), use Zest-Server is built on top of NodeJS.
          It is a rendering server mapping page routes to Render Components. Render Components support a highly flexible composition with
          regions allowing the entire page to be a Render Component. The route arguments then form the options object for this page Render
          Component, creating a natural server architecture.
          
          
          
          Components form a tree, with the page itself at the root. Dynamic information is passed via events that are triggered on
          components, and would typically be communicated up to parent components which have attached listeners. The idea being that
          parents understand their direct children's public interfaces only, all the way up the page hierarchy. This model is entirely
          optional though - how you choose to connect the controllers to any model implementations is left up to you.
          
          For extending components, the Zest Object Extension model (ZOE) provides a natural JavaScript inheritance and eventing framework
          which comes bundled with Zest. This allows flexible multiple inheritance of components.
          
          Because components are written with building and the browser in mind from the start, this process makes sharing
          components and building for production effortless. With a single line of configuration all resources are processed into a single
          minified JavaScript file allowing maxium efficiency.
        """
      ]
    ]
###