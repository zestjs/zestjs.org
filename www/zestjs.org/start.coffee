define ['cs!./doc-page/doc-page'], (DocPage) ->
  title: 'Zest Quick Start'
  body: DocPage
  options:
    section: 'start'
    data: [
      chapterName: 'Zest Quick Start'
      sections: [
        sectionName: 'Getting Started'
        markdown: """

          There are two template applications provided to quickly get started with Zest.

          The [Zest Client Quick Start](#Install%20Zest%20Client) template demonstrates browser rendering and builds.

          The [Zest Server Quick Start](#Install%20Zest%20Server) template demonstrates server routing and rendering with NodeJS.

          A brief introduction to [rendering](#Render%20Components), [server modules](#Server%20Modules) and 
          [builds](#Production%20Builds) is provided with these templates as a reference.

          For further background, [read the conceptual introduction](/why-zest).

          For the comprehensive guide to rendering, [read the documentation here](/docs).
                    
        """
      ,
        sectionName: 'Engage'
        markdown: """
          If you're stuck or have any questions, post a comment on the [ZestJS Google Group](http://groups.google.com/group/zestjs).
          
          To report issues or get involved in the development, [find ZestJS on GitHub](https://github.com/zestjs).
        """ 
      ]
    ,
      chapterName: 'Installation'
      sections: [
        sectionName: 'Install Zest Client'
        markdown: """
          The best way to start an application is by installing one of the application templates with Volo.

          > [Volo](http://volojs.org) is a package manager that allows for creating project templates and installing project dependencies such as jQuery (`volo add jquery`).
            It's a convenient way to get started with Zest and manage project dependencies. There are many package managers which would also work just as well.

          1. * Either use Volo to install the client template, by ensuring you have [NodeJS installed](http://nodejs.org), then installing Volo
               and creating the project from the template:

                ```
                  npm install volo -g
                  volo create myapp zestjs/template-browser
                ```

               This will download the template and all its dependencies to the 'myapp' folder.

             * Alternatively, [download the browser template directly here](https://github.com/downloads/zestjs/template-browser/zest-template-browser.zip).

          2. Run the app by opening up `www/index.html` in the browser.

        This loads up RequireJS with the minimal Zest configuration, and then renders a sample component into the page.

        This technique can be used to create single page apps, with all Zest rendering occurring in the browser.

        #### CoffeeScript Template

          Writing Render Components with CoffeeScript is a lot neater. To see the sample in CoffeeScript, use the version from:

          ```
            volo create myapp zestjs/template-browser-cs
          ```

          or [download the CoffeeScript browser template here](https://github.com/downloads/zestjs/template-browser-cs/zest-template-browser-cs.zip).

        #### Next Steps

        With the application set up, follow the [Render Component Introduction](#Render%20Components) below.

        ***

        """
      ,
        sectionName: 'Install Zest Server'
        markdown: """
        
          1. To install Zest server, install Zest and Volo as global modules (ensure you have [NodeJS](http://nodejs.org/) installed):

            ```
              npm install volo zest -g
            ```
          
          2. To create a Zest application, use [Volo](http://volojs.org) to automatically generate the application from the basic server template:
            ```
              volo create myapp zestjs/template-basic
            ```

            This will create a new folder called 'myapp' containing the project template, and download all the necessary Zest dependencies into the public library folder.

            Alternatively, if not using Volo, you can [download the server template here](https://github.com/downloads/zestjs/template-basic/zest-template-basic.zip).

          3. * To start the template application, simply run `zest` from within the zestapp folder:
              ```
                cd zestapp
                zest
              ```
             * Alternatively, if you want to use Zest Server from within NodeJS, run the NodeJS server at:
              ```
               node ~node-server.js
              ```
          
          5. Navigate to <http://localhost:8080/> and <http://localhost:8080/test> to see the site.
          
        #### CoffeeScript Template

          For the same template, but written as a CoffeeScript server, use the following install command:

          ```
            volo create myapp zestjs/template-basic-cs
          ```

          Or download the [CoffeeScript server template here](https://github.com/downloads/zestjs/template-basic-cs/zest-template-basic-cs.zip).

          #### Next Steps

          With the server installed, follow the [Render Component introduction below](#Render%Components).

        ***
          
        """
      ]
    ,
      chapterName: 'Quick Starts'
      sections: [
        sectionName: 'Render Components'
        markdown: """
        
      In both template apps, you are greeted to an incredibly simple welcome component. So how does this component get rendered?
      
      In both cases, it is rendered by the Zest render function. 

      With Zest Server, the application routing matches the URL to a component to render with some options.

      With the Zest Client example, the main application code entry point simply runs the render directly in the form:
      
      ```javascript
        $z.render('app/Hello/hello', {}, document.body);
      ```
      
      The first parameter is the RequireJS moduleId for the component. RequireJS moduleIds are just like file paths, but excluding the
      extension and base path. So the above means: render the component located at `www/app/Hello/hello.js`, and append it into the body of the page.
      
      The second parameter is an empty options object. This means that we're not passing any render options to the component,
      and are simply loading it with the default options.
      
      The Render Component file at `www/app/Hello/hello.js` is:

      ```javascript
        define(['zest', 'jquery', 'css!./hello'], function($z, $) {
          return {
            options: {
              name: ' to ZestJS'
            },
            render: function(o) {
              return '&lt;div class="welcome">Welcome ' + $z.esc(o.name, 'htmlText') + '.&lt;/div>';
            },
            attach: function(els) {
              setTimeout(function() {
                $(els).fadeIn(500);
              }, 1000);
            }
          };
        });
      ```
      
      * The use of **define** is the standard way of defining a JavaScript module in [RequireJS](http://requirejs.org) (and in any AMD loader).
      * The array, `['zest', jquery', 'css!./hello']` specifies the **dependencies** for the Render Component, loading
        the zest client library, jQuery and the `hello.css` modular styles into the page before running the definition callback.
      * When loading the module, the component definition callback function is called by RequireJS with the Zest client library and
        jQuery as its arguments, and it returns the defined JavaScript module conforming to the **Render Component** interface.
      
    The render function then reads this object taking the following steps:
      
      1. It takes the provided options object and sets the **default options** onto it from the `options` property on the Render Component.
      2. Most importantly, it runs the `render` function on the component, which is the **template function**. This function
         takes the render options and returns the HTML ready for the browser.
      3. After injecting the HTML, it then applies the `attach` method, which takes an argument containing the rendered array
        of DOM elements from the template. This allows dynamic interactions to be created, in this case a fade in with jQuery.
      
      The `attach` function can be a separate module by setting its value to the moduleId string to use.

      In this way we don't need to download the unnecessary render code into the browser when rendering on the server.
      
      The `attach` function can return a **controller** object which allows the component to communicate with other
      modules and components on the page.
      
    To learn more about rendering from the first principles, read the [Render Component Introduction](/docs#Writing%20Render%20Components).
    
    ***

        """
      ,
        sectionName: 'Server Modules'
        markdown: """
        
    In the server sample, the entry point for Zest is the zest configuration file. This can be called `zest.json` or `zest.cson`. It is
    simply a JSON configuration file informing Zest how to create the server.

    The template configuration file (`zest.json`) has contents:

    ```javascript
      {
        // load the application module (app.js)
        modules: ['$/app'],

        // RequireJS config - exactly as in RequireJS docs
        require: {
          paths: {
            app: '../app'
          },

          // requirejs build config (exactly as in requirejs docs, but with defaults provided)
          build: {
            zestLayer: {
              include: ['$attach!app/home']
            }
          }
        },

        // port to run the server on
        port: 8080
      }
    ```

    
    In this example it tells the server what port to run on, which modules to load and what RequireJS configuration to use, including for the optimized build.
    
    In order for the server to handle requests, it defines **modules** to load. In this case, just the one module `$/app`.
    
    This is a server RequireJS moduleId on the server, specifying 'app.js' must be loaded from the server root.
    
    The contents of this module are (`/app.js`):
    
    ```javascript
      define({
        routes: {
          '/': 'app/home',
          '/{name}': 'app/home'
        }
      });
    ```
    
    The module is defined as a RequireJS module, returning just the Zest module object in this case, with no dependencies. 

    One of the options a module can provide is a set of routes. In this case, we have two routes: the base url (/) and any first level url (/something).
    
    Zest server checks each request against the module routes in order. When the URL matches a module route, it uses that route to provide
    the server response. The value of the route is the **Render Component** to use for that page. In this case, `www/app/home.js`.
    
    The render options are populated from the url based on the variable parts of the url. For example, a request to `/test` will pass the
    render options object, `{ name: 'test' }`, to render the component `app/home`.
    
    Inside `/www/app/home.js` we have:
    ```javascript    
      define(['app/Hello/hello'], function (Hello) {
        return Hello;
      });
    ```
    
    The home page is simply returning the Hello component, which is then being rendered.
    
    Read more about [rendering](/docs#Writing%20Render%20Components) and [server modules](/docs#Zest%20Server) in the documentation.
        
    ***

        """
      ,
        sectionName: 'Production Builds'
        markdown: """
        
    When we launch, we can build all our files into one single file to load in the page.
    
    #### Zest Server Build

    If using the server example, simply type:
    
    ```
      zest start production
    ```
    
    to run the server, instead of just the `zest` command. This will run the build and start the server.
    
    #### Zest Client Build

    If using the client example, first install the RequireJS Optimizer in NodeJS with npm:
    ```
      npm install requirejs -g
    ```
    
    Then navigate to the project folder and type:
    ```
      r.js -o build.js
    ```

    This will build the main `www` folder into a new folder, `www-built`. Load up `www-built/index.html` to see the production version of the site.

    ***
    
    Looking at the browser network console in these production pages, there is only one script being loaded in the page for all resources, including
    the 90KB of jQuery.

    For both builds, we only need to specify one build include: `$attach!app/home` on the server template, and `../main` in the browser template.

    From this, all the dependencies are traced, compiled and included in a single built file.

    Read more on the [build process in the documentation](/docs#Building).

        """
      ]
    ]
