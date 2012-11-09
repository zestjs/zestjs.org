define ['cs!./doc-page/doc-page'], (Docs) ->
  structure: Docs
  options:
    title: 'Getting Started'
    section: 'start'
    data: [
      chapterName: 'Getting Started'
      sections: [
        sectionName: 'Contents'
        markdown: """
          1. [Introduction](#Introduction) - The very quick introduction.
          2. [Install Zest Server](#Install%20Zest%20Server) - Install the NodeJS render server.
          3. [Install Zest Client](#Install%20Zest%20Client) - Install Zest in the browser only.
          4. [An Introduction to Writing Zest Components](#An%20Introduction%20to%20Writing%20Zest%20Components) - Create extensible and portable components.
          5. [Creating Zest Server Modules](#Creating%20Zest%20Server%20Modules) - Build an entire website with Zest server.
        """
      ,
        sectionName: 'Engage'
        markdown: """
          If you're stuck or have any questions, post a comment on the [ZestJS Google Group](http://groups.google.com/group/zestjs).
          
          To report issues or get involved in the development, [find us on GitHub](https://github.com/zestjs).
        """
      ]
    ,
      chapterName: 'Quick Start'
      sections: [
        sectionName: 'Introduction'
        markdown: """
          At its core, Zest simply renders JavaScript **Component** definitions. Think of a component like a jQuery plugin. It consists of some HTML, CSS and then an attachment such as a domReady or JavaScript call. With Zest all of these steps are included in a single JavaScript definition file, as a **Component**.
          
          Zest comes with two identical rendering functions - one for the server and one in the browser.
          
          * For client rendering only, simply add the Zest Client JavaScript framework to the page (30KB in total before gzip), following the <a href='#Install Zest Client'>Zest Client quick start</a> below.
          * To render components on the server, use Zest-Server which is built on top of NodeJS. It is a rendering server mapping page routes to components. This allows the whole page to be built out of compositions of components.
          
          > For the full rendering details, [read the zest.render specification here](/docs/render)
          
          Regardless of which version you use, the core of Zest is the render process:
          
          ```javascript
            $z.render('componentId', {options}, destination);
          ```
          * Components are managed as [RequireJS](http://requirejs.org) modules, so that _componentId_ is the RequireJS moduleId for the component being rendered. Typically RequireJS _moduleId's_ are just the file path relative to a baseUrl, but without the '.js' extension.
          * _{options}_ sets the instance options for the creation of the component. For example, a slideshow would need a list of images and a width and height.
          * _destintation_ is where the component will be rendered. On the server, this is the NodeJS response object. In the browser, this is the container document element. For example, `document.body`.
          
          That is pretty much the core of what Zest does. It renders the component, ensures the CSS is on the page, and applies the JavaScript enhancements for dynamic elements. It also comes with an optional flexible inheritance model for dynamic components using JavaScript classes, and is fully-compatible with the RequireJS optimizer allowing project builds into a single JavaScript file.
          
          [Read more about the high-level overview and benefits of the Zest component architecture here](/why-zest).
        """
      ,
        sectionName: 'Install Zest Client'
        markdown: """
          Either use Volo to install the client template:
          
          ```
            npm install volo -g
            volo create exampleapp zestjs/template-browser
          ```
          
          Or simply [download the full repository for the browser example from GitHub](https://github.com/zestjs/template-browser).
          
          Run the app by opening up `www/index.html`.
          
          This loads up RequireJS with the minimal zest configuration, and then renders a sample component into the page.
          
          This technique can be used to create single page apps, with all Zest rendering occurring on the client.
          
        """
      ,
        sectionName: 'Install Zest Server'
        markdown: """
          The best way to start an application is by installing one of the application templates with Volo.
        
          1. To install Zest server, first ensure you have [NodeJS](http://nodejs.org/) installed.
          
          2. Install Zest and Volo as global modules:
            > [Volo](http://volojs.org) is used for package management in Zest, allowing for creating project templates and installing project dependencies such as jQuery.
          
            ```
              npm install volo zest -g
            ```
          
          3. To create a Zest application, use [Volo](http://volojs.org) to automatically generate the application from a template:
            ```
              volo create zestapp zestjs/template-basic
            ```
          
            This will create a new folder called 'zestapp' containing the project template, and download all the necessary Zest dependencies into the public library folder.
          
          4. To start the template application, simply run `zest` from within the zestapp folder:
            ```
              cd zestapp
              zest
            ```
          
          5. Navigate to <http://localhost:8080/> and <http://localhost:8080/test> to see the template site in action.
          
          ***
          
        """
      ]
    ,
      chapterName: 'An Introduction to Writing Zest Components'
      sections: [
        sectionName: 'The Simplest Component'
        markdown: """
          So what is actually going on here?
          
          Well first, let's go back a step. What is Zest doing? At it's core, Zest breaks down any website into **Components**. Think of components like a jQuery plugin. It consists of some HTML, a bit of CSS and then an attachment such as a domReady or JavaScript call. With Zest all of these steps are included in a single JavaScript definition file, as a **Component**. [To read more about the benefits of this approach, read the high-level motivation here](/why-zest).
          
          > CSON is a lot more convenient for writing config files than JSON since property quotes, braces and commas can be left out. If you don't like it, `zest.json` is used as a default fallback.
    
          The logic path of the server bootstrap is the following:
          
          * Zest checks the config file, `zest.cson` (CoffeeScript JSON file) in the application directory and builds up the server from this configuration.
          * As part of the process, it checks the `modules` property, and sees it must load the `cs!$/application` module.
          * Zest loads the CoffeeScript file `application.coffee` from the application folder, and reads it for module information.
            
            _Modules are loaded as [RequireJS](http://requirejs.org) dependencies. For server requires, Zest provides the `$/` path reference to the base application folder. Zest also comes with the [RequireJS CoffeeScript plugin](https://github.com/jrburke/require-cs) preinstalled. The `cs!` part is the CoffeeScript plugin name indicating that we want to load the module as a CoffeeScript file._
            
          * Inside the module, Zest reads the `routes` property, which is an object mapping URL patterns to Zest components.
          
        """
      ,
        sectionName: 'Adding Interaction'
        markdown: """
        """
      ,
        sectionName: 'Loading Data'
        markdown: """
        """
      ]
    ,
      chapterName: 'Creating Zest Server Modules'
      sections: [
        sectionName: 'Working with Routes'
        markdown: """
        """
      ,
        sectionName: 'Useful Configuration Options'
        markdown: """
        """
      ,
        sectionName: 'Creating Request Handlers'
        markdown: """
        """
      ]
    ]
