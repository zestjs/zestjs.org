define ['cs!./doc-page/doc-page'], (Docs) ->
  render: Docs
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
      ,
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
          
          Rendering is naturally an asynchronous operation. This means server rendering can be streamed. On the client chunked rendering is not currently
          suppported although the rendering is still asynchronous.
          
          For post-rendering attachment, use the optional render complete hook:
          ```javascript
            $z.render('componentId', {options}, destination, completeFunction);
          ```          
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
    
    By defining all render components as RequireJS modules, this allows us to manage modular dependencies, code portability and builds.
    
    button1.js:
    ```javascript
      define([], function() {
        return {
          render: '&lt;button>Hello World&lt;/button>'
        };
      });
    ```
    
    We simply create an object with a template property. Note that the template must always start with an HTML tag, otherwise an error
    will be thrown.
    
    This guide is interactive - the above file has already been created in this site, so that it can be found at the RequireJS
    moduleId, `app/button`. _ModuleId's_ in RequireJS are like paths to files, but including configured path mappings, relative to a
    baseUrl, and excluding the '.js' extension.
    
    To render this template we use `zest.render` in the browser with the following code:
    
    > This is a live example. Click 'Run' to see it in action, or edit the code to change it.
    
    ```jslive
      $z.render('app/button1', {}, document.querySelector('.container-1'));
    ```
    
    <div class='container-1' style='margin: 20px;'></div>
    
    The above code renders the component with an empty options object, into the container div with class 'container-1'
    (conveniently located right below the code block). Click run to see it render.
    
    Since we are running the live demo site, the button is already built into the scripts that loaded with this page, so it
    renders instantly. In development, or when the component hasn't been loaded already, a request for the script will be sent.
        """
      ,
        sectionName: 'Rendering with Options'
        markdown: """
    
    Templates are much more interesting when they can be customised with data. Let's allow the button to be given custom text:
    
    ```javascript
      define([], function() {
        return {
          render: function(o) {
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
          render: buttonTemplate
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
    
    To do this, we use [RequireCSS](https://github.com/guybedford/require-css) to load the CSS as a dependency of the component:
    
    > If you want to use LESS instead of CSS, there is the [RequireLESS](https://github.com/guybedford/require-less) plugin
      which behaves identically to RequireCSS but for LESS code.
    
    ```javascript
      define(['css!./button'], function() {
        return {
          type: 'BigButton',
          render: function(o) {
            return '&lt;button>' + o.text + '&lt;/button>';
          }
        }
      });
    ```
    
    The use of './' in the dependency name is the RequireJS syntax for a relative path so our code remains completely portable.
    
    We also need a unique class on the component to ensure our CSS is properly scoped. We can either add a class name into the template,
    or we can give the component a Component Type Name, which is specified with the `type` property above.
    
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
          render: function(o) {
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
        sectionName: 'Rendering with Dynamic Attachment'
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
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(o, els) {
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
    
    #### Some nitty gritty if you're interested
    
    When rendering on the server, Zest automatically rewrites the above code containing just the 'attachment' code, by removing the properties
    associated with rendering - `options`, `render`, `load` and `pipe`.
    
    This is done by loading the render component through the RequireJS plugin `zest/attach!`, which then builds just the necessary parts for the
    attachment of the component when running a build.
    
    It may seem unnecessary just to ensure we can write our render and attachment code in the same file, but when prototyping it
    makes life easier and feels a lot nicer.
    
    There is no loss though as it is still possible to have the render and attachment parts as separate files. Simply reference a string attach moduleId
    in the attach property, and then create a separate module containing just the attach function property as above.
    
    #### And if you're not...
    
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
            text: 'Button',
            message: 'Message'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          pipe: function(o) {
            return {
              msg: o.msg
            };
          },
          attach: function(o, els) {
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
          
    The standard way of combining components is with the use of named template regions. These are defined in the template
    with a special syntax allowing them to contain render components themselves.
    
    For example, we can create a dialog component which can contain any content:
    
    dialog.js:
    ```javascript
      define(['css!./dialog'], function() {
        return {
          type: 'SimpleDialog',
          render: function(o) {
            return "&lt;div>{&#96;content&#96;}&lt;/div>"
          }
        };
      });
    ```
    
    dialog.css:
    ```css
      div[component="SimpleDialog"] {
        background-color: #ccc;
        padding: 20px;
        border: 1px solid #999;
      }
    ```
    
    The `content` region is denoted by the special syntax <code>&#96;{RegionName}&#96;</code>. Any number of regions
    can be provided with any region names.
    
    The regions can be populated by setting the region name property on either the component itself, or through the options.
    Setting the region on the component will take preference over the region in the options, allowing for 'private regions'.
    
    In this example, the region is public as we haven't set it already.
    Hence we can populate the region to any content when creating any dialog instance.
    
    
    For example, we can include a simple component in the dialog:
    ```jslive
      $z.render('app/dialog1', {
        content: {
          render: '&lt;span>some content&lt;/span>'
        }
      }, document.querySelector('.container-7'));
    ```
    <div class='container-7' style='margin: 20px'></div>
    
    We could also set a default content for the 'content' region by providing this property in the default options (the `options`
    property on the component), so that if not provided the default would apply.
    
        """
      ,
        sectionName: 'Private Template Regions'
        markdown: """
    
    Let's create a private region in the dialog as well that is pre-populated with a button:
    
    ```javascript
      define(['app/button6', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
          render: function(o) {
            return "&lt;div>{&#96;content&#96;}&lt;div class='footer'>{&#96;footer&#96;}&lt;/div>&lt;/div>"
          },
          footer: {
            render: Button,
            options: {
              text: 'Dialog button',
              msg: 'Dialog message'
            }
          }
        };
      });
    ```
    
    This region can't be overridden with the instance options because it is already defined on the dialog itself.
    
    By importing the 'button' component, a build of the dialog will now also contain the build of the button so that we can still
    build this compound component.
    
    Run the code here:
    ```jslive
      $z.render('app/dialog2', {
        content: {
          render: '&lt;span>more content&lt;/span>'
        },
        footer: {
          render: '&lt;span>this content ignored&lt;/span>'
        }
      }, document.querySelector('.container-8'));
    ```
    <div class='container-8' style='margin: 20px'></div>
        

    In this way, we can build up complex layout components and component combinations from simple component parts,
    all of which can still be rendered by a single render call.
    
    This means an entire page can be a component, allowing us to render pages both client and server-side seamlessly,
    while still allowing full build support.
        
        """
      ,
        sectionName: 'Allowed Renderables'
        markdown: """
    When populating the regions, we weren't referencing moduleIds, instead we were providing **renderables**. There are actually
    a number of renderable forms accepted by `zest.render` which are called **renderables**. The **render component** we've been using
    up until now is just one of them.
    
    The full list of renderables is:
      
    * **moduleId, string**: _A moduleId, pointing to a renderable. Just as we've been using when rendering components._
    * **render component, object**: _A render component, indicated by the `template` property, as we've been using._
    * **renderable array, array**: _An array of renderables will be rendered one after another. Useful for regions with lots of components._
    * **dynamic renderable, function**: _A function that returns a renderable. The function takes the options of the render returning a new renderable._
    * **instance render, object**: _Allows rendering a renderable with the given options. Indicated by a `structure` property. Form:_
      ```javascript
      {
        render: renderable,
        options: {...options...}
      }
      ```
      _This is what allowed us to provide a specific button instance in the dialog renderable._
      
    We could have used a dynamic renderable to optionally show the dialog button:
    
    ```javascript
      define(['app/button6', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
          options: {
            closeButton: false
          },
          render: function(o) {
            return "&lt;div>{&#96;content&#96;}&lt;div class='footer'>{&#96;footer&#96;}&lt;/div>&lt;/div>"
          },
          footer: function(o) {
            if (!o.closeButton)
              return null;
            else
              return {
                render: Button,
                options: {
                  text: 'Close',
                }
              };
          }
        };
      });
    ```
    
    By making the footer region a dynamic renderable function of the component options itself, we're able to dynamically provide the region content.
    
    Without the close button (the default):
    ```jslive
      $z.render('app/dialog3', {
        content: {
          render: '&lt;span>more content&lt;/span>'
        }
      }, document.querySelector('.container-9'));
    ```
    
    With the close button:
    ```jslive
      $z.render('app/dialog3', {
        closeButton: true,
        content: {
          render: '&lt;span>more content&lt;/span>'
        }
      }, document.querySelector('.container-9'));
    ```
    <div class='container-9' style='margin: 20px'></div>
    
          """
      ,
        sectionName: 'Attaching Controllers'
        markdown: """
    
    So lets try and make this example vaguely useful. The Button should be hookable so that when its clicked the Dialog can hide itself.
    
    We need to 'attach' to the click event of the button.
    
    In order to do this, the button needs to provide a controller that we can use to communicate with it.
    
    **The return value of an 'attach' function is the controller for that render component.**
    
    Adding this to the button (since we no longer need a message we've removed this and the pipe function):
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(o, els) {
            var _clickCallback = function(){};
            var buttonController = {
              setClickCallback: function(callback) {
                _clickCallback = callback;
              }
            };
            els[0].addEventListener('click', function() {
              _clickCallback();
            });
            return buttonController;
          }
        };
      });
    ```
    
    So where does the controller go? It gets registered by zest and linked to the unique id that is generated for each button instance.
        """
      ,
        sectionName: 'The Component Selector'
        markdown: """
          The standard way of getting access to the component controller is by using a **component selector**.
          
          This is just like a jQuery selector:
            
          ```javascript
            $z(selectorString, context);
          ```
          
          The selectorString can use ids and names for component type names. Also spaces are allowed for hierarchical selections. No other selector syntax is supported currently.
          The context is an optional container element within which to do the selection.
          
          Examples:
            
          ```javascript
            $z('Button'); //returns array of all 'Button' components ([component=Button] type name).
            $z('Dialog Button'); //returns array of all 'Button' components inside any 'Dialog' component.
            $z('#myDialog Button', myDiv); //returns array of all 'Button' components inside the component with id '#myDialog', within the containing element, 'myDiv'
          ```
          
          The return value is an array of components or a single component if there is only one.
          The return value is the single item if it is found. When there is a controller provided for a component, it returns the controller. When no controller has been assigned, it just returns the array of DOM elements for the component.
          
          Let's create a button with a given id and then use the component selector to get its controller:
          
          ```jslive
            $z.render('app/button7', {
              id: 'controllerButton',
              text: 'ControllerButton'
            }, document.querySelector('.container-10'), function() {
            
              $z('#controllerButton').setClickCallback(function() {
                alert('custom callback!');
              });
              
            });
          ```
          <div class='container-10' style='margin: 20px'></div>
          
          Note that because rendering is asynchronous, we've put the interaction code in the complete callback for the render function
          to ensure that rendering is completed before we run the component selector.
        
        """
      ,
        sectionName: 'Disposal'
        markdown: """
        
    The controller can have any methods it wants. The only method that zest makes assumptions about is the **dispose** method.
    If it exists, this method is called when the element is disposed.
    
    Let's be good and add a dispose method to our button controller to ensure we don't create any memory leaks:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(o, els) {
            var _clickCallback = function(){};
            var clickEvent = function() {
              _clickCallback();
            }
            
            els[0].addEventListener('click', clickEvent);
            return {
              setClickCallback: function(callback) {
                _clickCallback = callback;
              },
              dispose: function() {
                els[0].removeEventListener('click', clickEvent);
              }
            };
          }
        };
      });
    ```
    
    ```jslive
      $z.render('app/button8', {
        id: 'controllerButton2',
        text: 'ControllerButton'
      }, document.querySelector('.container-11'), function() {
      
        var button = $z('#controllerButton2');
        button.setClickCallback(function() {
          button.dispose();
        });
        
      });
    ```
    
    We can also dispose arbitrary HTML:
    ```jslive
      $z.render('app/button8', {
        id: 'controllerButton2',
        text: 'ControllerButton'
      }, document.querySelector('.container-11'), function() {
      
        var button = $z('#controllerButton2');
        button.setClickCallback(function() {
          $z.dispose(document.querySelector('.container-11'));
        });
        
      });
    ```
    
    <div class='container-11' style='margin: 20px'></div>
        """
      ,
        sectionName: 'Linking Everything Together'
        markdown: """
    So let's link together the button component with the dialog component so that the button disposes the dialog:
    
    dialog.js:
    ```javascript
      define(['app/button8', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
          options: {
            closeButton: false
          },
          render: function(o) {
            return "&lt;div>{&#96;content&#96;}&lt;div class='footer'>{&#96;footer&#96;}&lt;/div>&lt;/div>"
          },
          footer: function(o) {
            if (!o.closeButton)
              return null;
            else
              return {
                render: Button,
                options: {
                  text: 'Close'
                }
              };
          },
          pipe: function(o) {
            return {
              closeButton: o.closeButton
            };
          },
          attach: function(o, els) {
            if (o.closeButton)
              $z('BigButton', els).setClickCallback(function() {
                $z.dispose(els);
              });
          }
        };
      });
    ```
    
    And see it in action:
    ```jslive
      $z.render('app/dialog4', {
        closeButton: true,
        content: {
          render: '&lt;span>content&lt;/span>'
        }
      }, document.querySelector('.container-12'));
    ```
    <div class='container-12' style='margin: 20px'></div>
    
    ### Summary
    
    We manage the render components as one entity, while maintaining a strict separation between rendering and attachment so that
    server-rendering is naturally supported.
    
    For attachment, we provide custom controllers, which are merely JavaScript objects. To find controllers, we use the 'zest selector'
    just like in jQuery.
    
    The standard attachment process for a component that contains others is thus:
    1) Use a contextual component selector based on the current component context, to find sub components that require linking.
    2) Manually manage communication, registration and interaction between sub-components.
    
    This implies a hierarchical model to the development process, similar to a [PAC](http://www.vico.org/pages/PatronsDisseny/Pattern%20Presentation%20Abstra/) model.
    
    The exact implementations of this process is entirely left up to the user. Zest handles only the render process and no further.
    
    ***
    
        """
      ,
        sectionName: '$z.Component'
        markdown: """
        
    $z.Component provides one system for managing the dynamic interactions on components.
    
    It is a base class that can be implemented using the ZOE inheritance model designed for this purpose.
    
    It provides a number of helpers making the previous tasks easier to accomplish.
    
    These are:
    
    * Converting render components to support standard prototypal inheritance in JavaScript.
    * Full inheritance support for components with dynamic attachment, allowing the dynamic controllers to be extended.
    * Providing a contextual DOM selector on the component. It is automatically restricted to DOM elements of the component, and not those
      of its child components. The DOM selector can also be mapped to jQuery using a RequireJS config to allow for easy jQuery use.
    * A contextual component selector is also directly available on the component instance. The component selector
      is also automatically restricted to first-level subcomponents as well.
    * When using jQuery, events are automatically removed during disposal.
    * A natural eventing mechanism that is compatible with inheritance.
    
    Read the full specification in the documentation for $z.Component.
    
    ### Converting our Button and Dialog components to $z.Component
    
    We create the implementation with the `$z.create` function, implementing from `$z.Component`. This prepopulates the `attach`
    function automatically for us. The `construct` function becomes the constructor for the component object, and properties placed
    on the `prototype` object are the natural prototypal methods of the controller instance used for attachment.
    
    Thus, the button becomes:
    
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return $z.create([$z.Component], {
          type: 'BigButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          //these are the constructor and prototype for the controller:
          construct: function(o) {
            //if we configure the selector to jQuery, we can directly use
            //$('button').click(..etc...);
            this.$('button')[0].addEventListener('click', this.click);
          },
          prototype: {
            __click: function() {},
            dispose: function() {
              this.$('button')[0].removeEventListener('click', this.click);
            }
          }
        });
      });
    ```
    
    The '__click' notation indicates that the click function should be converted into a function that can be ammended
    with the 'on' method. This creates a form of basic eventing.
    
    The dialog then becomes:
    
    ```javascript
      define(['zest', 'app/button9', 'css!./dialog'], function($z, Button) {
        return $z.create([$z.Component], {
          type: 'SimpleDialog',
          options: {
            closeButton: false
          },
          render: function(o) {
            return "&lt;div>{&#96;content&#96;}&lt;div class='footer'>{&#96;footer&#96;}&lt;/div>&lt;/div>"
          },
          footer: function(o) {
            if (!o.closeButton)
              return null;
            else
              return {
                render: Button,
                options: {
                  text: 'Close'
                }
              };
          },
          pipe: function(o) {
            return {
              closeButton: o.closeButton
            };
          },
          construct: function(o) {
            if (o.closeButton)
              this.$z('BigButton').click.on(this.close);
          },
          prototype: {
            __close: function() {
              $z.dispose(this.$$);
            }
          }
        });
      });
    ```
    
    Note also that it isn't necessary to bind the 'close' method to the prototype instance. By default, functions defined with the
    '__' syntax are automatically scoped to make communication easier.
    
    See that it behaves the same here:
    ```jslive
      $z.render('app/dialog5', {
        closeButton: true,
        content: {
          render: '&lt;span>content&lt;/span>'
        }
      }, document.querySelector('.container-13'));
    ```
    <div class='container-13' style='margin: 20px'></div>
        
    
    ### $z.Component Benefits Illustrated
    
    Leave the above dialog open (by clicking run and not the close button). Then run this example:
    
    ```jslive
      var buttonInstance = $z('BigButton', document.querySelector('.container-13'));
      //hook the click method
      buttonInstance.click.on(function() {
        alert('button clicked!');
      });
      //do a click (entirely equivalent in behavior to actually clicking the button)
      buttonInstance.click();
    ```
    
    To create a new dialog that extends the previous dialog, it's also much easier:
    
    ```javascript
      define(['app/dialog5'], function(Dialog) {
        return $z.create([Dialog], {
          prototype: {
            newMethod: function() {
              alert('new instance method');
            },
            __close: function() {
              alert('new dialog closed!');
            }
          }
        });
      });
    ```
    
    The same eventing method works with inheritance.
    
    Try the extended dialog here:
    ```jslive
      $z.render('app/dialog6', {
        closeButton: true,
        content: {
          render: '&lt;span>content&lt;/span>'
        }
      }, document.querySelector('.container-14'), function() {
        
        $z('SimpleDialog', document.querySelector('.container-14')).newMethod();
      
      });
    ```
    <div class='container-14' style='margin: 20px'></div>
        
    ***
        
        """
      ,
        sectionName: 'CoffeeScript Components'
        markdown: """
        
    The final enhancement we can do is to convert our components into CoffeeScript. The multi-line string support with interpolation
    makes the templates easier to write, and the code looks nicer in general.
    
    button.coffee:
    ```coffeescript
      define ['zest', 'css!./button'], ($z) ->
        $z.create([$z.Component],
          type: 'BigButton'
          options:
            text: 'Button'
          render: (o) -> &quot;&lt;button>&#35;{$z.esc(o.text, 'htmlText')}&lt;/button>&quot;
          
          construct: (o) ->
            @$('button')[0].addEventListener 'click', @click
          prototype:
            __click: ->
            dispose: ->
              @$('button')[0].removeEventListener 'click', @click
        )
    ```
    
    dialog.coffee:
    ```coffeescript
      define ['zest', 'cs!app/button', 'css!./dialog'], ($z, Button) ->
        $z.create([$z.Component],
          type: 'SimpleDialog'
          options:
            closeButton: false
          render: (o) -> &quot;&quot;&quot;
            &lt;div>
              {&#96;content&#96;}
              &lt;div class='footer'>{&#96;footer&#96;}&lt;/div>
            &lt;/div>
          &quot;&quot;&quot;
          
          footer: (o) ->
            if !o.closeButton
              null
            else
              render: Button
              options:
                text: 'Close'
          
          pipe: (o) ->
            closeButton: o.closeButton
            
          construct: (o) ->
            if o.closeButton
              @$z('BigButton').click.on @close
          prototype:
            __close: ->
              @dispose();
        )
    ```
    

        
    With the RequireJS CoffeeScript plugin we simply add the `cs!` prefix to the requireId:
    
    ```jslive
      $z.render('cs!app/dialog', {
        closeButton: true,
        content: {
          render: '&lt;span>content&lt;/span>'
        }
      }, document.querySelector('.container-15'));
    ```
    <div class='container-15' style='margin: 20px'></div>

    ***
        """
      ]
    ,
      chapterName: 'Creating Zest Server Modules'
      sections: [
        sectionName: 'A simple server'
        markdown: """
          
    The server is entirely built up from the zest.cson file config. It is assumed that `www/lib` is the main RequireJS baseUrl, but this
    can be customized with configuration. In the `www/lib` folder, it is expected that there is an install of zest client and its dependencies
    (done with `volo add zest-client`).
    
    If using the basic template, this is already done for you.
          
          
        
        
    > CSON is a lot more convenient for writing config files than JSON since property quotes, braces and commas can be left out. If you don't like it, `zest.json` is used as a default fallback.

    The logic path of the server bootstrap (run when typing the `zest` command from the base folder) for is the following:
    
    1. Zest checks the config file, `zest.cson` (CoffeeScript JSON file) in the application directory and builds up the server from this configuration.
    2. It checks the `modules` object property, which lists module RequireJS Ids as keys.
    3. Zest loads the CoffeeScript file `application.coffee` from the application folder, and reads it for module information.
      
      _Modules are loaded as [RequireJS](http://requirejs.org) dependencies. For server requires, Zest provides the `$/` path reference to the base application folder. Zest also comes with the [RequireJS CoffeeScript plugin](https://github.com/jrburke/require-cs) preinstalled. The `cs!` part is the CoffeeScript plugin name indicating that we want to load the module as a CoffeeScript file._
      
    * Inside the module, Zest reads the `routes` property, which is an object mapping URL patterns to Zest components. The variables in the
      url patterns get turned into the options to be used in the `zest.render` call.
    
    * By default, 

        """
      ,
        sectionName: 'Useful Configuration Options'
        markdown: """
        """
      ]
    ]
