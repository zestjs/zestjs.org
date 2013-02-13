define ['cs!./doc-page/doc-page'], (DocPage) ->
  title: 'ZestJS - Modular Render Components'
  body: DocPage
  layers: ['demo']
  options:
    section: 'start'
    data: [
      chapterName: 'ZestJS'
      sections: [
        sectionName: 'Modular Render Components'
        markdown: """

      ZestJS provides client and server rendering for static and dynamic HTML widgets (**Render Components**) written as AMD
      modules providing low-level application modularity and portability.

      1. Write widgets as AMD Render Components.
      2. Render them on the client or server with a single render call, loading them through RequireJS.
      3. Build with the RequireJS Optimizer into a single file or layers in production, including the compilation of CSS or LESS and templates.

      ### Client Rendering

      Include RequireJS and the Zest Client library (10KB minified and gzipped) in the page, then use the provided render function:

      ```jslive
        $z.render('@app/dialog', {

          content: "&lt;p>Welcome to ZestJS.&lt;/p>",
          width: 300,
          height: 50,
          confirmText: 'Ok'

        }, document.querySelector('.dialog-example'));
      ```
      <div class="dialog-example"></div>

      _Click "run" above to see the render._

      * This loads the render component located RequireJS Module ID, `app/dialog`.
      * The component is then rendered with the given content, dimensions and button text.
      * It is injected into the div above with class `.dialog-example`.

      ### Server Rendering

      Use the provided NodeJS server module or the dedicated render server.

      [Click here for the example component rendered on the server](/dialog).

      * The exact same component is now rendered on the server, with assets and scripts attached seamlessly.
      * The CSS blocks the HTML page render stream to show only styled widgets.
      * The dynamic attachment can optionally block the page render stream until its scripts have loaded,
        or it can be configured for progressive enhancement.
      * In production, scripts are loaded fully compatible with built script layers.

      ### Demonstration

      Components can be combined together with regions allowing for compound components. This home page is a compound render component with separate header,
      sidebar and content regions.

      Written as a Render Component, despite this page being rendering on the server, we can re-render this home page from the client quite easily.
      This includes generating all the HTML from markup, attaching the scroll detection in the contents on the left and enabling the live code `run` buttons.

      _Click the run button below._

      ```jslive
        // start preloading
        require(['demo']);

        // clear the page
        $z.dispose(document.body.childNodes);
        document.body.scrollTop = 0;
        
        // render a dialog
        $z.render('@app/dialog', {

          content: "&lt;p>Render the homepage from the client.&lt;/p>",
          width: 300,
          height: 50,
          confirmText: 'Go'

        }, document.body, function(Dialog) {

          Dialog.Button.click.on(function() {

            // render the homepage
            $z.render('@cs!site/home', document.body, function() {
              document.body.scrollTop = 1090; 
            });

          });

        });
      ```

      <div class='test'></div>

      * We completely cleared the page, then rendered a dialog.
      * On the dialog controller, we register an event to the button click.
      * When clicked, the Zest render function dynamically requested this home page component with RequireJS.
      * RequireJS handles compilation of the site CoffeeScript, LESS and Markdown dynamically.
      * Zest then rendered the page component into the body, applying the dynamic attachments predictably.      

      Note that in production we would never normally download the compilers to the browser, this is only useful in development as it
        allows us to have an efficient on-demand compilation removing the need for a development build.

      **Zest gives you:**

      * A way of managing modular render component files with AMD.
      * Custom controller registration for interacting with dynamic components.
      * Nested component rendering with regions.
      * A natural modularity for frontend code based on controller hierarchies.
      * Natural build support through AMD including CSS or LESS, templates and attachments on both the client and server.
      * Browser support in IE7+ and the rest.

      **Zest doesn't give you:**

      * Models or binding - the choices here are left up to you.
      * A DOM manipulation library.
      * A dictated environment - it's more of a tool and a method than a framework.

      ***

        """
      ,
        sectionName: 'Writing Render Components'
        markdown: """

      A Render Component consists of two AMD modules:

      1. A **renderer** which can be used to generate HTML on the client or server, while specifying CSS dependencies.
      2. An **attachment** which is executed on the client to add interaction to the DOM. For static components with
         no interaction, this can be left out.

    The renderer takes the following form as an AMD module:

    > The use of **define** is the standard way of defining a JavaScript module in [RequireJS](http://requirejs.org) (and in any AMD loader),
      where the first array argument specifies the dependencies for the module.

      button.js:
      ```javascript
      define(['zest', 'tpl!./button', 'less!./button'], function($z, template) {
        return {
          
          // provide default options
          options: {
            text: 'Default Text'
          },

          // dynamic options processing (async also supported)
          load: function(options) {
            options.text = $z.esc(options.text, 'htmlText');
          },

          // provide the template function returning HTML
          render: template,

          // reference the attachment module
          attach: './button-controller'

        };
      });
      ```

      * The renderer conforms to the expected **Render Component** specification so it can be rendered by a `$z.render` call.
      * Rendering takes some options data, which gets populated with defaults or processed.
      * By making the CSS or LESS a dependency of the module, this provides client injection, server tracing and modular CSS build support.
      * A RequireJS template plugin can load a template file and return a JavaScript function to provide as the `render` property. A custom
        function or string returning HTML from the options data can also be used.

    The attachment module takes the following form:

      button-controller.js:
      ```javascript
        define(['zest', 'jquery'], function($z, $) {
          // enhancement function
          return function(el, o) {
            
            // standard frontend code
            $(el).click(function() {
              // ...
            });
            
            // returns a controller object
            return {
              method: function() {
                // controller method
              }
            };
          }
        });
      ```

      * The attachment is called on the client with the DOM element and attachment options as arguments.
      * The optional return value is a JavaScript object to be used as the controller.
      * Controllers can be found using the selector `$z.select('.Button')`, where the selector is a standard DOM selector,
        making debugging from the console straigthforward.
    
    [Try it out yourself by installing ZestJS](#Install), or to learn more about rendering from the first principles, 
    read the [Render Component Introduction](/docs#Writing%20Render%20Components).
    
    ***

        """
      ,
        sectionName: 'Server Modules'
        markdown: """

    Server rendering can be performed via a NodeJS API, as an HTML render service (just a like a database server), or
    using a Zest Server module. The HTML render service module could easily be linked into other server languages through
    a bridge library, providing the rendering function for other frameworks.

    Zest Server modules map routes into components, which are then rendered with options from the URL.

    /app.js:
    ```javascript
      define({
        routes: {
          '/': {
            title: 'Example Page',
            body: '@my-component',
          }
        }
      });
    ```

    In all of these rendering modes, the server is configuration-based. An example configuration to run the above module would be:

    zest.json:
    ```javascript
      {
        // port to run the server on
        port: 8080

        // load the application module (app.js)
        modules: ['$/app'],

        // RequireJS config - exactly as in RequireJS docs
        require: {
          // requirejs build config (exactly as in requirejs docs, but with defaults provided)
          build: {
            zestLayer: {
              include: ['^!app/my-component']
            }
          }
        }
      }
    ```

    This can then be started by running the `zest` command at the root of the application.
    
    Read more about [rendering](/docs#Writing%20Render%20Components) and [server modules](/docs#Zest%20Server) in the documentation.
        
    ***

        """
      ,
        sectionName: 'Production Builds'
        markdown: """
        
    When we launch, we can build all our files into one single file to load in the page, or use layered builds to have separate
    blocking and asynchronous layers for the page load.
    
    #### Zest Server Build

    For the server above, we would instead start our server with:
    
    ```
      zest start production
    ```
    
    This will run the build and start the server, loading the given component from a single script, including the compiled LESS and template.
    
    #### Zest Client Build

    For client apps, we invoke the RequireJS Optimizer manually, using the standard optimization command:

    ```
      r.js -o build.js
    ```

    An example client build is provided in the sample browser app templates.

    Read more on the [build process in the documentation](/docs#Building).

        """
      ]
    ,
      chapterName: 'Install'
      sections: [
        sectionName: 'Getting Started'
        markdown: """

          There are two template applications provided to quickly get started with Zest.

          The [Zest Client Quick Start](#Install%20Zest%20Client) template demonstrates browser rendering and builds.

          The [Zest Server Quick Start](#Install%20Zest%20Server) template demonstrates server routing and rendering with NodeJS.

          A brief introduction to [rendering](#Render%20Components), [server modules](#Server%20Modules) and 
          [builds](#Production%20Builds) is provided here.

          For further background, [read the conceptual introduction](/why-zest).

          For the comprehensive guide to rendering, [read the documentation here](/docs).
                    
        """
      ,
        sectionName: 'Install Zest Client'
        markdown: """
          The best way to start an application is by installing one of the application templates with Volo.

          > [Volo](http://volojs.org) is a package manager that allows for creating project templates and installing project dependencies such as jQuery (`volo add jquery`).
            It's a convenient way to get started with Zest and manage project dependencies. Other package managers can also work with Zest - feel free to send a pull request.

          1. Use Volo to install the client template, by ensuring you have [NodeJS installed](http://nodejs.org), then installing Volo
               and creating the project from the template:

                ```
                  npm install volo -g
                  volo create myapp zestjs/template-browser
                ```

               This will download the template and all its dependencies to the 'myapp' folder.

          2. Run the app by opening up `www/index.html` in the browser.

        This loads up RequireJS with the minimal Zest configuration, and then renders a sample component into the page.

        This technique can be used to create single page apps, with all Zest rendering occurring in the browser.

        #### CoffeeScript Template

          Writing Render Components with CoffeeScript is a lot neater. To see the sample in CoffeeScript, use the version from:

          ```
            volo create myapp zestjs/template-browser-cs
          ```

          The CoffeeScript template also comes with `less` in the sample app as well.

        #### Next Steps

        Follow the [Render Component Introduction](#Writing%20Render%20Components) above, or [read the full guided documentation](/docs).

        ***

        """
      ,
        sectionName: 'Install Zest Server'
        markdown: """
        
          1. To install Zest server, install Zest and Volo as global modules (ensure you have [NodeJS](http://nodejs.org/) installed):

            ```
              npm install volo zest-server -g
            ```
          
          2. To create a Zest application, use [Volo](http://volojs.org) to automatically generate the application from the basic server template:
            ```
              volo create myapp zestjs/template-basic
            ```

            This will create a new folder called 'myapp' containing the project template, and download all the necessary Zest dependencies into the public library folder.

          3. * To start the template application, simply run `zest` from within the myapp folder:
              ```
                cd myapp
                zest
              ```
             * Alternatively, if you want to use Zest Server from within NodeJS, run the NodeJS server at:
              ```
               node ~node-server.js
              ```
          
          5. Navigate to <http://localhost:8080/> and <http://localhost:8080/test> to see the site.
          
        #### CoffeeScript Template

          For the same template, but written as a CoffeeScript server and using LESS, use the following install command:

          ```
            volo create myapp zestjs/template-basic-cs
          ```

          #### Next Steps

          With the server installed, follow the [Render Component introduction](#Writing%20Render%20Components), or [read the full guided documentation](/docs).

        ***
          
        """
      ,
        sectionName: 'Engage'
        markdown: """
          If you're stuck or have any questions, post a comment on the [ZestJS Google Group](http://groups.google.com/group/zestjs).
          
          To report issues or get involved in the development, [find ZestJS on GitHub](https://github.com/zestjs).
        """
      ]
    ]
