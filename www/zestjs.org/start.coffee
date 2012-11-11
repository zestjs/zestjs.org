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
          4. [An Introduction to Writing Render Components](#An%20Introduction%20to%20Writing%20Render%20Components) - Create extensible and portable render components.
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
          * To render components on the server, use Zest-Server which is built on top of NodeJS. It is a rendering server mapping page routes to renderables. This allows the whole page to be built out of compositions of render components.
          
          > For the full rendering details, [read the zest.render specification here](/docs/render)
          
          Regardless of which version you use, the core of Zest is the render process:
          
          ```javascript
            $z.render('componentId', {options}, destination);
          ```
          * Render Components are managed as [RequireJS](http://requirejs.org) modules, so that _componentId_ is the RequireJS moduleId for the component being rendered. Typically RequireJS _moduleId's_ are just the file path relative to a baseUrl, but without the '.js' extension.
          * _{options}_ sets the instance options for the creation of the component. For example, a slideshow would need a list of images and a width and height.
          * _destintation_ is where the component will be rendered. On the server, this is the NodeJS response object. In the browser, this is the container document element. For example, `document.body`.
          
          That is pretty much the core of what Zest does. It renders the component, ensures the CSS is on the page, and applies the JavaScript enhancements for dynamic elements. It also comes with an optional flexible inheritance model for dynamic render components using JavaScript classes, and is fully-compatible with the RequireJS optimizer allowing project builds into a single JavaScript file.
          
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
      chapterName: 'An Introduction to Writing Render Components'
      sections: [
        sectionName: 'Basic Rendering'
        markdown: """          
          
    Let's start with simplest render component, which simply provides a template.
    
  > This is the standard AMD module definition format used by [RequireJS](http://requirejs.org). The standard define statement takes two
    arguments - an array of dependency names (strings), and a callback function. The callback is called once the dependencies have been
    loaded, with the loaded dependencies as ordered arguments in the callback. In this case, there are no dependencies - we simply return
    the render component object directly to define the module.
    
    Regardless of whether you are using the zest-server or zest-browser template, you would create a file
    called 'button.js' in the 'www/app' folder. (We're creating numbered buttons here because we have a bit of evolution to go through.)
    
    button1.js:
    ```javascript
      define([], function() {
        return {
          template: '&lt;button>Hello World&lt;/button>'
        };
      });
    ```
  
    By defining all render components as RequireJS modules, this allows us to manage modular dependencies, code portability and builds.
    
    This guide is interactive - the above file has already been created in this site, so that it can be found at the RequireJS
    moduleId, `app/button`. _ModuleId's_ in RequireJS are like paths to files, but including configured path mappings, relative to a
    baseUrl, and excluding the '.js' extension.
    
    Thus, to render this template we use `zest.render` in the browser with the following code:
    
    > This is a live example. Click 'Run' to see it in action, or edit the code to change it.
    
    ```jslive
      $z.render('app/button1', {}, document.querySelector('.container-1'));
    ```
    
    <div class='container-1' style='margin: 20px;'></div>
    
    Since we are running the live demo site, the button is already built into the scripts that loaded with this page, so it will
    render instantly. In development, or when the component hasn't been loaded already, a request for the script will be sent.
    
    The above code renders the component with an empty options object, into the container div with class 'container-1'
    (conveniently located right below the code block). Click run to see it render.
        """
      ,
        sectionName: 'Rendering with Options'
        markdown: """
    
    Templates are much more interesting when they can be customised with data. Let's allow the button to be given custom text:
    
    ```javascript
      define([], function() {
        return {
          template: function(o) {
            return '&lt;button>' + o.text + '&lt;/button>';
          }
        };
      });
    ```
    
    And then lets render it again:
    
    ```jslive
      $z.render('app/button2', {
        text: 'Click Me!'
      }, document.querySelector('.container-2'));
    ```          
    <div class='container-2' style='margin: 20px;'></div>
    
    Note how the template is now a function instead of a string. The options object we pass into the render function gets passed
    to the template function, which can read out the options it needs.
    
    #### CoffeeScript templates
    
    CoffeeScript is easily supported by RequireJS and allows multiline strings and interpolation.
    This makes writing components in the above format much easier to use.
    
    #### Template processors
    
    On the other hand, you can also use a template processor through a RequireJS loader plugin
    which parses template syntax, and supports builds.
    
    For example with the [RequireJS Jade plugin](https://github.com/rocketlabsdev/require-jade) we can load the template
    as Jade syntax from `button.jade`:
    
    ```javascript
      define(['jade!./button'], function(buttonTemplate) {
        return {
          template: buttonTemplate
        };
      });
    ```
    
    Since the jade plugin supports builds, the above would also support adding the compiled template into the build, without including
    the processor in production.
    
    There is a list of supported templating languages on the [RequireJS plugins page](https://github.com/jrburke/requirejs/wiki/Plugins#wiki-templating).
    
        """
      ,
        sectionName: 'Adding CSS'
        markdown: """
          
    The next thing we're probably going to want to do is add some styles to our component.
    
    To do this, we use [RequireCSS](https://github.com/guybedford/require-css) to load the CSS as a dependency of the component.
    The use of './' in the dependency name is the RequireJS syntax for a relative path so our code remains completely portable.
    
    We also need a unique class on the component to ensure our CSS is properly scoped. We can either add a class name into the template,
    or we can give the component a Component Type Name, which we demonstrate here:
    
    ```javascript
      define(['css!./button'], function() {
        return {
          type: 'BigButton',
          template: function(o) {
            return '&lt;button>' + o.text + '&lt;/button>';
          }
        }
      });
    ```
    
    > By default Zest adds the `component` attribute to all render components. If you'd rather write valid XHTML, you can configure
      Zest to use the attribute `data-component` instead.
    
    When rendering, the `type` name is automatically added as the `component` attibute on the element, so the HTML will render as the element:
    
    ```
      <button component='BigButton'>
    ```
      
    It is worth ensuring this name is unique to the component as it may clash with other components on the page.
    
    We can then use the attribute selector in our CSS as the main scope. Attribute-equals selectors are supported in IE7+ and on mobile devices.
    If you need IE6 support, rather add a class to the template HTML and style the class instead.
    
    We create _button.css_ in the same folder:
    ```css
      button[component="BigButton"] {
        font-size: 20px;
        font-family: verdana;
        cursor: pointer;
        padding: 10px;
      }
    ```
    
    See this in action here:
    ```jslive
      $z.render('app/button3', {
        text: 'Click Me!'
      }, document.querySelector('.container-3'));
    ```          
    <div class='container-3' style='margin: 20px;'></div>
          
    **By having a separate CSS file for each component we are forced to write properly modular CSS, making maintenance and portability much easier.**
  
    Again, because these components have already been built into the script file loaded with the page, the CSS is already present in the browser before we even
    render the component.
    
    In development and for CSS not yet loaded, the CSS is downloaded as needed.
    
    Read more about this at the [RequireCSS](https://github.com/guybedford/require-css) project page.
          
        """
      ,
        sectionName: 'Default Options and Escaping'
        markdown: """
    What if someone doesn't provide text? Or worse, what if they provide text containing a cross site scripting attack?
    
    Let's clean this up and add some default options and escaping.
    
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          template: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          }
        };
      });
    ```
    
    The `options` property on the render component specifies default options to be populated if not already present.
    
    The `zest` library comes with an escaping function, `$z.esc`, which provides escaping for attributes, htmlText, filteredHtml, urls, numbers and string variables.
    
    Now we can try out the edge cases with no 'text' option provided:
    ```jslive
      $z.render('app/button4', {}, document.querySelector('.container-4'));
    ```
    
    And most importantly, script attacks:
    ```jslive
      $z.render('app/button4', {
        text: '&lt;script>steal(document.cookie);&lt;/script>'
      }, document.querySelector('.container-4'));
    ```
    <div class='container-4' style='margin: 20px'></div>
    
    So now our component is safe from attacks and no one ever needs to see the output, 'undefined'.
    
        """
      ,
        sectionName: 'Rendering with Attachment'
        markdown: """
    
    Right, so how about we actually do something when we click the button?
    
    Let's add the dynamic attachment code:
    
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          template: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els) {
            els[0].addEventListener('click', function() {
              alert('click');
            });
          }
        };
      });
    ```
    
    ```jslive
      $z.render('app/button5', {
        text: 'Click Me!'
      }, document.querySelector('.container-5'));
    ```
    <div class='container-5' style='margin: 20px'></div>
    
    `els` is the array of DOM elements that were rendered from the template. Hence `els[0]` is the button element itself.
    
    The attach property can also be a _moduleId_ string to reference a separate module to use for attachment, but it feels a lot nicer
    having things in once place.
    
    #### Some nitty gritty for those interested
    
    When rendering on the server, Zest automatically rewrites the above code containing just the 'attachment' code, by removing the properties
    associated with rendering - `options`, `template`, `load` and `pipe`.
    
    This is done by loading the render component through the RequireJS plugin `zest/attach!`, which then builds just the necessary parts for the
    attachment of the component when running a build.
    
    It may seem unnecessary just to ensure we can write our render and attachment code in the same file, but when prototyping it
    makes life easier and feels a lot nicer.
    
    There is no loss though as it is still possible to have the render and attachment parts as separate files. Simply reference a string attach moduleId
    in the attach property, and then create a separate module containing just the attach function property as above.
    
    #### And for those not...
    
    All of this is done in the background to ensure writing a component is as simple as possible.
    
    
        """
      ,
        sectionName: 'Piping Options to Attachment'
        markdown: """
  
    What about custom attachment options, say for example, we want an option customise the message provided
    when you click the button?
      
    The pipe method is used to generate the 'attachment options':
    
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          template: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          pipe: function(o) {
            return {
              msg: o.msg
            };
          },
          attach: function(els, o) {
            els[0].addEventListener('click', function() {
              alert(o.message);
            });
          }
        };
      });
    ```
    
    Pipe is a function, taking the main options object (as given to the template) and outputting the options object to use for
    attachment. These options are then sent as the second argument to the `attach` function.
    
    
    ```jslive
      $z.render('app/button6', {
        text: 'Msg Button',
        msg: 'Its a message'
      }, document.querySelector('.container-6'));
    ```
    <div class='container-6' style='margin: 20px'></div>
    
    The benefit of pipe, is that when we render a component on the server, we dont need to send down all the data that was used
    to perform the rendering to the client - we only send the attachment options that we want to pipe to the client. Consider a gallery
    component that renders images from raw image data, there is no reason to send all this raw JSON image data to the client once its been generated
    into HTML.
    
    If you like, you can directly send the render options itself, or even delete options off the render options object first that shouldn't be piped
    (since this is the last render function, these options aren't needed anymore). It is generally better to just pipe each property directly though.
    
      """
      ,
        sectionName: 'Template Regions'
        markdown: """
    For layout components like tables, accordions and tabs you can define regions. These are specified with a region syntax in the template string:
    
    ```jslive
    
      var TwoColumn = {
        template: "&lt;table>&lt;tr>&lt;td>{&#96;columnOne&#96;}&lt;/td>&lt;td>{&#96;columnTwo&#96;}&lt;/td>&lt;/tr>&lt;/table>"
      };
      
      //exactly as before...
      var Button = {
        options: {
          msg: 'Hi', // the message when you click the button
          text: 'Button' // the button text
        },
        template: function(o) {
          return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
        },
        pipe: function(o) {
          return {
            msg: o.msg
          };
        },
        attach: function(els, o) {
          els[0].addEventListener('click', function() {
            alert(o.msg);
          });
        }
      }
      
      $z.render(TwoColumn, {
        columnOne: Button,
        columnTwo: Button
      }, document.querySelector('.render-placeholder-6'));
    ```
      <div class='render-placeholder-6' style='margin: 20px'></div>
      
      The region itself can be set either as a property of the component itself (an internal region), or as an option for the template.
      
      If the region is set as a property of the component itself, then it will not be possible to override it with options.
    
      """
      ,
        sectionName: 'Alternative Render Structures'
        markdown: """
  Note how the buttons both have the default options only. To send individual options to the buttons we can use an instance render, which is different from
  a component render.
  
  Instead of having the column containing the button component, we provide an object with the properties `structure` and `options`. `structure` indicates the
  component or structure to render, and `options` the options to render for it.
    
  ```jslive
    //exactly as before...
    var TwoColumn = {
      template: "&lt;table>&lt;tr>&lt;td>{&#96;columnOne&#96;}&lt;/td>&lt;td>{&#96;columnTwo&#96;}&lt;/td>&lt;/tr>&lt;/table>"
    };
    
    //exactly as before...
    var Button = {
      options: {
        msg: 'Hi', // the message when you click the button
        text: 'Button' // the button text
      },
      template: function(o) {
        return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
      },
      pipe: function(o) {
        return {
          msg: o.msg
        };
      },
      attach: function(els, o) {
        els[0].addEventListener('click', function() {
          alert(o.msg);
        });
      }
    }
    
    //create buttons differently:
    $z.render(TwoColumn, {
      columnOne: {
        structure: Button,
        options: {
          text: 'First column button'
        }
      },
      columnTwo: {
        structure: Button,
        options: {
          text: 'Second column button'
        }
      }
    }, document.querySelector('.render-placeholder-7'));
  ```
  <div class='render-placeholder-7' style='margin: 20px'></div>
    
  It is also possible to provide an array of renderables to a region to allow for many components one after another in the region.

        """
      ,
        sectionName: 'CoffeeScript Components'
        markdown: """
        
    If we use CoffeeScript, we can get multi-line string support and interpolation, which
    makes writing inline templates much more natural (although we can load templates from external files when written in RequireJS
    module definitions).
      
    Here's the previous component in CoffeeScript:
    
  ```cslive
    TwoColumn =
      template: \"\"\"
        &lt;table>&lt;tr>
          &lt;td>{&#96;columnOne&#96;}&lt;/td>
          &lt;td>{&#96;columnTwo&#96;}&lt;/td>
        &lt;/tr>&lt;/table>
      \"\"\"
    
    Button =
      options:
        msg: "Hi"
        text: "Button"
      
      template: (o) ->
        "&lt;button>\#{$z.esc o.text, 'htmlText'}&lt;/button>"
        
      pipe: (o) ->
        msg: o.msg

      attach: (els, o) ->
        els[0].addEventListener "click", ->
          alert o.msg
    
    $z.render TwoColumn,
      columnOne:
        structure: Button
        options:
          text: "First column button"
      columnTwo:
        structure: Button
        options:
          text: "Second column button"
    , document.querySelector(".render-placeholder-7");
  ```
    <div class='render-placeholder-8' style='margin: 20px'></div>
    
    These gains make writing components in CoffeeScript much easier and more elegant.
        """
      ,
        sectionName: 'RequireJS File Organisation'
        markdown: """
  
  With the examples above, we wouldn't normally write our components as variables but rather into separate files in the `www/app` folder.
  
  Public libraries are included in the `www/lib` folder so we rely on a path mapping `app`, which maps from the public to the app folder.
  
  To organise our code as RequireJS modules that can be loaded asynchronously, we write one component per file
  using the RequireJS module definition format.
  
  We would write our components as:
  
  **button.js** (in the www/app folder):
  ```coffeescript
    define [], () ->
      options:
        msg: "hi"
        text: "button"
      
      template: (o) ->
        "&lt;button>\#{$z.esc o.text, 'htmlText'}&lt;/button>"
        
      pipe: (o) ->
        msg: o.msg

      attach: (els, o) ->
        els[0].addEventListener 'click', ->
          alert o.msg
  ```
  
  **two-column.js**:
  ```coffeescript
    define [], () ->
      template: \"\"\"
        &lt;table>&lt;tr>
          &lt;td>{&#96;columnOne&#96;}&lt;/td>
          &lt;td>{&#96;columnTwo&#96;}&lt;/td>
        &lt;/tr>&lt;/table>
      \"\"\"
  ```
  
  Then in the browser we can write:
  
  ```javascript
    $z.render('cs!app/two-column', {
      columnOne: {
        structure: 'cs!app/button'
        options: {
          msg: 'first'
        }
      },
      columnTwo: {
        structure: 'cs!app/button'
        options: {
          msg: 'second'
        }
      }
    }, containerDiv);
  ```
  
  Within the app folder, code organisation is completely unimposed. Helper functions, models and CSS dependencies can all be loaded
  as relative paths from the component itself, allowing comprehensive component dependency management.
  
  
    To dispose, we can simply use `$z.dispose` to clean up all components inside a wrapper element. This includes the facility for a disposal hook in the components themselves,
    allowing for clean event detachment and custom unloading.
    
    ```jslive
      $z.dispose(document.querySelector('.render-placeholder-1'));
    ```
  
        """
      ]
    ,
      chapterName: 'Creating Zest Server Modules'
      sections: [
        sectionName: 'Working with Routes'
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
        sectionName: 'Useful Configuration Options'
        markdown: """
        """
      ,
        sectionName: 'Creating Request Handlers'
        markdown: """
        """
      ]
    ]
