define ['cs!./doc-page/doc-page'], (Docs) ->
  render: Docs
  options:
    title: 'Zest Quick Start'
    section: 'start'
    data: [
      chapterName: 'Zest Quick Start'
      sections: [
        sectionName: 'Getting Started'
        markdown: """
          
          For a comprehensive overview of what Zest does, read [Why Zest](/why-zest). This explains the primary motivations
          for Zest, as well as the basic concepts behind the Zest Render Component specification.
            
          To use Zest for browser rendering only, without installing NodeJS, get started by following the [Zest Client
          install](#Install%20Zest%20Client) below, then read the [Render Component quick start](#Render%20Components).
          
          To use Zest for server and browser rendering with a NodeJS server, follow the [install instructions for
          Zest Server](#Install%20Zest%20Server), then read the [Render Component quick start](#Render%20Components),
          as well as the [introduction to server modules](#Server%20Modules).
          
          Both of the above setups support production builds easily. To test this out, follow the [build quick start](#Production%20Builds).
          
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
          Either use Volo to install the client template:
          
          ```
            npm install volo -g
            volo create exampleapp zestjs/template-browser
          ```
          
          Or simply [download the full sample folder](https://github.com/downloads/zestjs/template-browser/zest-template-browser.zip).
          
          Run the app by opening up `www/index.html`.
          
          This loads up RequireJS with the minimal Zest configuration, and then renders a sample component into the page.
          
          This technique can be used to create single page apps, with all Zest rendering occurring on the client.
          
        """
      ,
        sectionName: 'Install Zest Server'
        markdown: """
          The best way to start an application is by installing one of the application templates with Volo.
        
          1. To install Zest server, first ensure you have [NodeJS](http://nodejs.org/) installed.
          
          2. Install Zest and Volo as global modules:
            > [Volo](http://volojs.org) is package manager that allows for creating project templates and installing project dependencies such as jQuery.
              It's a convenient way to get started with Zest and manage project dependencies.
          
            ```
              npm install volo zest -g
            ```
          
          3. To create a Zest application, use [Volo](http://volojs.org) to automatically generate the application from the basic template:
            ```
              volo create zestapp zestjs/template-basic
            ```
          
            This will create a new folder called 'zestapp' containing the project template, and download all the necessary Zest dependencies into the public library folder.

          4. The server application can be used eitherTo start the template application, simply run `zest` from within the zestapp folder:
            ```
              cd zestapp
              zest
            ```
          
          5. Navigate to <http://localhost:8080/> and <http://localhost:8080/test> to see the template site in action.
          
          ***
          
        """
      ]
    ,
      chapterName: 'Quick Starts'
      sections: [
        sectionName: 'Render Components'
        markdown: """
        
      In both template apps, you are greeted to an incredibly simple welcome component. So how does this component get rendered?
      
      In both cases, it is rendered by the Zest render function. In Zest Server, the application uses the URL to determine what component
      to render, and with what options. This is what Zest Server modules do.
      
      In the Zest Client example, the main application code entry point simply runs the render directly in the form:
      
      ```javascript
        $z.render('app/WelcomeComponent/welcome-component', {}, document.body);
      ```
      
      The first parameter is the RequireJS moduleId for the component. The above means - render the component located at
      `www/app/Welcomecomponent/welcome-component.js` directly into the body of the page.
      
      The second parameter is an empty options object. This means that we're not passing any render options to the component,
      and are simply loading it with the defaults.
      
      Let's have a look at the component code:

      ```javascript
        define(['jquery', 'css!./welcome-component'], function($) {
          return {
            options: {
              name: ' to ZestJS'
            },
            render: function(o) {
              return '&lt;div class="welcome">Welcome ' + o.name + '.&lt;/div>';
            },
            attach: function(o, els) {
              setTimeout(function() {
                $(els).fadeIn(500);
              }, 1000);
            }
          };
        });
      ```
      
      * The use of **define** is the standard way of defining a JavaScript module in RequireJS (and in any AMD loader).
      * The array, `['jquery', 'css!./welcome-component']` specifies the **dependencies** for the Render Component, loading
        both the `welcome-component.css` file for the modular styles and the `jQuery` library before defining the component.
      * When loading the module, the component definition function is called by RequireJS with jQuery as the first argument, which
        returns the a JavaScript object conforming to the **Render Component** interface.
      
    The render function then takes the following steps:
      
      1. It takes the provided options object and sets the **default options** onto it from the `options` property on the Render Component.
      2. Most importantly, it runs the `render` function on the component, which is the **template function**. This function
         takes the render options and returns the HTML ready for the browser.
      3. After injecting the HTML, it then applies the `attach` method, which takes an argument containing the rendered DOM array
        from the template. This allows dynamic interactions to be created, in this case a fade in with jQuery.
      
      On the server, the `attach` function can be separated by providing a separate moduleId for it. In this way we don't need
      to download the unnecessary render code into the browser.
      
    Additionally, the `attach` function can return a **controller** object which allows the component to communicate with other
      modules and components on the page.
      
    To learn more about rendering from the first principles, read the [Render Component Introduction](/docs#An%20Introduction%20to%20Writing%20Render%20Components).
    
        """
      ,
        sectionName: 'Server Modules'
        markdown: """
        
    In the server sample, the entry point for Zest is the zest configuration file. This can be called `zest.json` or `zest.cson`. It is
    simply a JSON configuration file informing Zest how to create the server.
    
    In this example it tells the server what port to run on, which modules to load, what RequireJS configuration to use, including for the project build.
    
    In order for the server to handle requests, it defines **modules** to load. In this case, just the one module `$/app`.
    
    This is a RequireJS moduleId, since RequireJS runs on the server in Zest, which specifies 'app.js' must be loaded from the server root.
    
    The contents of this module are:
    
    ```javascript
      define({
        routes: {
          '/': 'app/home',
          '/{name}': 'app/home'
        }
      });
    ```
    
    The module is defined as a RequireJS module, returning the Zest module object. One of the options a module can provide is a set of routes.
    
    In this case, we have two routes: the base url (/) and any first level url (/something).
    
    Zest server checks each request against the module routes in order. When the URL matches a module route, it uses that route to provide
    the server response. The value of the route is the **Renderable** to use for that page. In this case, `www/app/home.js`.
    
    The render options are populated from the url based on the variable parts of the url. For example, a request to `/test` will use the
    options object: `{ name: 'test' }` to render the component `app/home`.
    
    Inside `www/app/home` we have:

    ```javascript    
      define(['app/WelcomeComponent/welcome-component'], function (WelcomeComponent) {
        return WelcomeComponent;
      });
    ```
    
    The home page is simply returning the Welcome Component, which is how it is being rendered.
    
    Read more about Server Modules in the documentation section.
        
        """
      ,
        sectionName: 'Production Builds'
        markdown: """
        
    When we launch, we can build all our files into one single file to load in the page.
    
    If using the server example, simply type:
    
    ```
      zest start production
    ```
    
    to run the server, instead of just the `zest` command. This will run the build and start the server.
    
    If using the client example, first install the RequireJS Optimizer in NodeJS with npm:
    ```
      npm install requirejs -g
    ```
    
    Then navigate to the project folder and type:
    ```
      r.js -o build.js
    ```
    
    In both examples, there will now only be one script resource loading everything needed for the page (including the 90KB of jQuery!).
        """
      ]
    ]