define ['cs!./doc-page/doc-page'], (DocPage) ->
  title: 'Documentation'
  body: DocPage
  options:
    section: 'why-zest'
    data: [
      chapterName: 'Why Zest'
      sections: [
        sectionName: 'Allowing for Modular Web Development'
        markdown: """
          > This website itself is built using Zest. You can view the source in the page or on [GitHub here](https://github.com/zestjs/zestjs.org).
        
          ZestJS is an open source JavaScript library that provides a way to build modular, maintainable modern web applications - both single page applications
          in the browser and multi-page applications with complex interactions.
          
          The key premise of Zest is in making the **Render Component** the unit of development.
          
          A render component is like a jQuery plugin. It consists of an HTML template, CSS style and JavaScript interaction. An example
          would be a slide show component or even a drop down menu, static layout or dialog.

          Zest makes front-end application development easier by bringing this simple, low-level modularity to the process. 
          Zest doesn't impose any unnecessary framework constraints, leaving the primary library decisions up to the developer.
          It is suitable for any form of HTML component modularity, from websites to cross-platform web applications. Since SVG is rendered with HTML, components
          can even be SVG-based allowing for vector component modularization as well.
          
          The benefits of a Render Component model include portability between sites and developers along with the open source
          benefits of this sharing. If you can break an entire web page or application specification down into render components, it's much easier to break down the
          workload between developers. Testing becomes easier as you can isolate separate components easily.
          
          _Zest grew out of the idea that there is a need to write such Render Components in a common format that can be easily installed,
          rendered on both the client and server, built for production and shared between sites without imposing unnecessary framework
          constraints, leaving the development environment as open and flexible as possible._
          
          Zest at its core is an implementation and specification for these components that works across all of today's devices and browsers.
        """
      ,
        sectionName: 'Designing for Many Environments'
        markdown: """
          
          The Render Component specification is designed to work in many scenarios:
          
          * Rendering without needing to run any build step
          * Rendering in optimized production environments
          * Rendering on the client
          * Rendering on the server
          
          [RequireJS](http://requirejs.org) is used in Zest for module management. It is based on the AMD module format and supports the
          above environments ideally.
          
          * It runs on both the server and the browser, allowing easy code sharing.
          * It provides build support with the [RequireJS optimizer](http://requirejs.org/docs/optimization.html) allowing
            modules and all their dependencies to be built into a single file with flexible options for script layering.
          * Resources, templates and other assets can be loaded as dependencies just like any other, with full optimized build support.
          
          RequireJS also allows very natural production and development environments.
          
          In development, all dependencies are loaded by the browser. There is no build step. This facilitates a very quick reload
          time between changes, which creates a fast feedback cycle for development work. Even compiled resources such as CoffeeScript
          or LESS are downloaded and compiled by the browser.
          This means that only the absolutely necessary development files for the current page are compiled as needed, saving time.
          
          In production, the dependencies can be built into a single script file. CoffeeScript is compiled into JavaScript and LESS into CSS,
          which can even be inlined within the script as well using [Require-CSS](https://github.com/guybedford/require-css). 
          All assets on the page can thus be loaded from a single script file from this simple build process, or layered to optimize load
          caching between pages.

          Components can be built for rendering or just attachment-only with the provided attachment build plugin. In this way, a popup could be
          built so that it can be dynamically rendered in the browser, while the render code for an image gallery rendered on the server
          can be excluded from the page load.
          
          The development and production environments behave identically, so that this build process is as effortless as possible.
        """
      ,
        
        sectionName: 'Client and Server'
        markdown: """

          Sharing the same rendering model between the client and server unifies the front-end development process. With a single render
          call, a page can be rendered from the browser that is also rendered on the server. We can have the benefits of dynamic
          application interaction, without page reloads, while still allowing search-engine crawling of all application pages.

          A Render Component renders based on some render options. For a gallery, it could be a set of image URLs; for a menu,
          the menu item names and links.
          
          The render process is broken down into two phases:
          
          1. Rendering the HTML from the options data.
          2. Attaching the dynamic functionality in the browser.
          
          When rendering in the browser, both phases happen together. When rendering on the server, the HTML is generated on the server,
          but the dynamic attachment only happens in the browser.

          The Zest client library handles all rendering, loading and attachment for components in the browser.
          
          Zest Server implements exactly the same rendering process on the server with NodeJS. Great care has been taken to ensure 
          that rendering behaves identically between the two. 

          The HTML output is designed so that it is impossible for the HTML to display before the styles have been loaded (including
          any LESS compilation in the browser). A common problem with dynamic front-ends is that one can often see HTML before it has
          had its dynamic scripts attached. With Zest, if you can see it, then the dynamic enhancement has been applied. An image
          gallery will work as soon as it is seen, even if the page is still loading.
                  
        """
      ,
        sectionName: "Dynamic Interaction Architecture"
        markdown: """
          To allow components to communicate with each other and other modules, they can define a controller which is simply
          a JavaScript object created during the attachment process. The entire controller interface is left up to the implementor.
          
          Zest doesn't impose an MVC pattern, rather the front-end architecture created by Zest is more comparable to a 
          [PAC model](http://en.wikipedia.org/wiki/Presentation%E2%80%93abstraction%E2%80%93control).

          Components form a hierarchy, with each component containing any number of sub-components within regions of its template.

          The idea is that each parent will typically communicate with the controllers of its direct children and in turn for
          their children, simply through the listening to and triggering of events.

          The architecture of the application emerges from this natural modularization.

          The architecture is merely implied. How the controllers and models are connected is left entirely to the developer.
        """
      ,
        sectionName: "Zest Component Extension Model"
        markdown: """

          Zest provides a suggested way of setting up component eventing and inheritance.
          
          This is referred to as the [Zest Object Extension model (ZOE)](http://zoejs.org/).
          
          It's a small JavaScript inheritance model with eventing. It was designed from the ground up to work with
          Zest Render Components.
          
          It provides a simple class pattern, which makes it very easy to define controllers as JavaScript classes
          with events and methods on the object prototype. If all components use the same event model, it is obviously much easier for them to
          communicate with each other.
          
          The inheritance model is provided to facilitate the creation of extensible components. An abstract image gallery component
          could be extended into a more specific gallery component, with a toolbar and theme, while providing a unified controller
          and build support as part of the extension process.
        """
      ,
        sectionName: "Integrating Server Rendering"
        markdown: """
        
          Zest Server typically performs routing, which maps a URL to a page Render Component.

          Zest Server can provide this rendering in a number of ways:

          1. As an entire application server.
          2. As a dependency in a NodeJS application to provide page rendering.
          3. As a rendering service, to integrate with another framework or platform. It provides
            'rendering as a service' over HTTP, mapping JSON options and a componentId to rendered HTML.

        For (3), bridge modules could provided just like for a database to hook into the Zest rendering engine.
        """
      ,
        sectionName: "Loading Data"
        markdown: """

          When rendering, components can get their data in two ways:
          
          1. **From the initial render options.**
            In this case, all of the data for the page is acquired and provided as a single JavaScript object. The page is then
            rendered from this options object, with each component passing down the necessary options to its sub-components.
          
          2. **From an internal load function during the rendering of the component.**
            Any Render Component can specify an asynchronous load function, allowing it to communicate with any model or service
            JavaScript dependencies. Zest provides an HTTP library with an identical HTTP request interface between the client
            and server, allowing components to communicate with local service requests.

            Since NodeJS is a streaming server, the HTML page stream is optimized around the load for each component.
            Zest Server renders as much as it can, until it hits a component still loading. It then waits for the component to complete,
            while also buffering the rendering of subsequent components.
              
            This also assists towards an optimal page load, as the user could already be interacting with components already rendered in the page,
            even while a heavy database load is still waiting to render HTML for the same page request.
          
        """
      ,
        sectionName: "Summary"
        markdown: """
          ZestJS is an open source system for defining and implementing Render Components, bringing together modular CSS, 
          dependency management, packaging and builds from the core.
          
          The rendering model is based purely on an object interface, supporting component inheritance and extension.
                    
          This has been found to have solved architecture issues with large JavaScript applications. The hope is that
          this can benefit others as well as form a part of the dialog for how to approach these problems as web technologies continue to evolve.
        """
      ,
        sectionName: "Next Steps"
        markdown: """
          Get started with Zest in either the browser or the server by following [the instructions on the Getting Started page](/start).
          
          Then dive straight into the [guided documentation on Render Components here](/docs).
          
          Engage on [Google groups](http://groups.google.com/group/zestjs), or [Github](https://github.com/zestjs).
          
          Suggestions, feedback and comments welcome.
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