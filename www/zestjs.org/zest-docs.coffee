define ['cs!./doc-page/doc-page'], (DocPage) ->
  title: 'Documentation'
  body: DocPage
  options:
    section: 'docs'
    data: [
      chapterName: 'Introduction'
      sections: [
        sectionName: 'Contents'
        markdown: """
        
          1. [Writing Render Components](#Writing%20Render%20Components)
          2. [Zest Server](#Zest%20Server)
        """
      ]
    ,
      chapterName: 'Writing Render Components'
      sections: [
        sectionName: 'Rendering'
        markdown: """

    If you don't yet have one of the example Zest templates installed, [follow the install guide here](/start#Install%20Zest%20Server).

    > Click 'Run' to execute the live render example. The code box is editable - feel free to play around with the examples here.

    Let's start with the simplest render and work our way up:

    ```jslive
      $z.render('&lt;p>hello world&lt;/p>', document.querySelector('.container-1'));
    ```

    <div class='container-1' style='margin:20px;'></div>

    The above code renders the HTML into the container div with  class _'container-1'_ (conveniently located right below the code block).

    All rendering in Zest is run through `zest.render`, which behaves identically on both the client and server.

    `zest.render` will render 5 different types of **Render Structure**, the HTML string as above being one of them.
    The full list of them is provided in the [Render Structures](#Render%20Structures) section we will get to shortly.

        """
      ,
        sectionName: 'Render Components'
        markdown: """          

    The most important render structure is the **Render Component**. Render components bring together HTML, JavaScript, CSS and interaction code.

    Render components are JavaScript objects with a `render` property.

    For this example, let's construct a custom button component:

    ```jslive
      $z.render({
        render: '&lt;button>Hello World&lt;/button>'
      }, document.querySelector('.container-2'));
    ```

    <div class='container-2' style='margin:20px;'></div>

    Instead of entering the HTML string directly, we've provided it as a `render` property. The `render` property
    is itself also rendered with `$z.render`.

    ### Render Component Modules

    > The [zest/zest-render.js](https://github.com/zestjs/zest/blob/master/zest-render.js) file can also be loaded directly allowing for rendering in non-AMD environments.

    By defining render components as [RequireJS](http://requirejs.org) modules, this allows us to manage code and style dependencies, code portability and builds.
    
    In both the zest-server or zest-browser template, we create `button.js` in the `www/app` folder (the buttons
      in this example are numbered as we have some evolving to do here).
    
    >  The define statement takes two arguments - an array of dependency moduleIds, and a callback function. The callback is called once the dependencies have been
    loaded, with the loaded dependencies as the arguments. The return of the callback is the defined module value.
    
    button1.js:
    ```javascript
      define([], function() {
        return {
          render: '&lt;button>Hello World&lt;/button>'
        };
      });
    ```

    The form above is the standard AMD module definition format used by [RequireJS](http://requirejs.org). It is just
    defining the render component with its `render` property as we saw previously.
    
    > _Module IDs_ in RequireJS are like paths to files, relative to a baseUrl and excluding the '.js' extension.

    The above file has already been created in this site, so that it can be found at the RequireJS
    **Module ID**, `app/button1`.
    
    We can then use `$z.render` to load and render from a Module ID directly by writing a `@` to indicate
    that the string is a module ID:
    
    ```jslive
      $z.render('@app/button1', document.querySelector('.container-3'));
    ```
    
    <div class='container-3' style='margin: 20px;'></div>

    The above will fetch the `button1.js` file, load it, then apply a `$z.render` on the loaded module.

    Since this is a production site, the button is already loaded with the single built script containing all dependencies for this page, thus it renders instantly. In development, or when the component hasn't been loaded already, a request for the script will be sent.
    Rendering is an asynchronous operation - it can optionally take a `complete` callback as its last argument.

        """
      ,
        sectionName: 'Rendering from Options'
        markdown: """

    Templates are just functions of options data. The 4<sup>th</sup> type of render structure is a **Render Function**. It is a function of render options, returning a render structure. In the case of a template, it can just return an HTML string:

    ```jslive
      var buttonTemplate = function(o) {
        return '&lt;button>' + o.text + '&lt;/button>';
      }
      $z.render(buttonTemplate, {
        text: 'Click Me!'
      }, document.querySelector('.container-4'));
    ```

    <div class='container-4' style='margin: 20px;'></div>

    The second argument provided to the `$z.render` function is the **options** object. It allows us to
    pass data to the render structure being rendered.

    Let's add this back into our **Render Component**:
    
    button2.js:
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
      $z.render('@app/button2', {
        text: 'Click Me!'
      }, document.querySelector('.container-5'));
    ```          
    <div class='container-5' style='margin: 20px;'></div>

        """
      ,
        sectionName: 'Template Plugins'
        markdown: """

    #### CoffeeScript for Templating
    
    CoffeeScript is easily supported by RequireJS and allows multi-line strings and interpolation.
    This allows an easy way for writing templates in-line while keeping Render Components nicely readable.
    
    #### Template Plugins
    
    On the other hand, you can also use a template processor through a RequireJS loader plugin
    which parses template languages and supports builds.
    
    For example with the [RequireJS Jade plugin](https://github.com/rocketlabsdev/require-jade) we can load the template
    as Jade syntax from `button.jade`:
    
    ```javascript
      define(['jade!./button'], function(buttonTemplate) {
        return {
          render: buttonTemplate
        };
      });
    ```
    
    Since the Jade plugin supports builds, the above would also support adding the compiled template into the build, without including
    the Jade compiler in production.
    
    There is a list of supported templating languages on the [RequireJS plugins page](https://github.com/jrburke/requirejs/wiki/Plugins#wiki-templating).
    
        """
      ,
        sectionName: 'Adding CSS'
        markdown: """
    
    CSS is loaded as a dependency of the Render Component with [RequireCSS](https://github.com/guybedford/require-css), which allows easy
    CSS build support as with any other dependency.
    
    > If you want to use LESS instead of CSS, there is the [RequireLESS](https://github.com/guybedford/require-less) plugin
      which behaves identically to RequireCSS but for LESS code. If using Volo, install it with `volo add guybedford/require-less`.
    
    button3.js:
    ```javascript
      define(['css!./button'], function() {
        return {
          className: 'MyButton',
          render: function(o) {
            return '&lt;button>' + o.text + '&lt;/button>';
          }
        }
      });
    ```
    
    The use of `./` in the dependency name is the RequireJS syntax for a relative path so our code remains completely portable. It loads
    `button.css` from the same folder as `button.js`.
    
    The `MyButton` class is added to the `<button>` HTML element for us when we specify the `className` property on the component.

    * className can be space-separated just like the DOM className property.
    * The className option allows for adding extra classes during instantiation, without overriding the component `className`.

  We create `button.css` in the same folder:
    ```css
      .MyButton {
        font-size: 12px;
        font-family: verdana;
        color: #fff;
        cursor: pointer;
        padding: 5px 20px;
        /* etc... */
      }
    ```
    
    See this in action here:
    ```jslive
      $z.render('@app/button3', {
        text: 'Click Me!'
      }, document.querySelector('.container-6'));
    ```          
    <div class='container-6' style='margin: 20px;'></div>      

    **By having a separate CSS file for each component we are forced to write properly modular CSS, making maintenance and portability much easier.**
  
    Again, since this component is built into the script file loaded with this page, the CSS is already present in the browser before we even render the component.
    
    In development and for CSS not yet loaded, the CSS is downloaded as needed.
    
    Read more about this process at the [RequireCSS](https://github.com/guybedford/require-css) project page.

        """
      ,
        sectionName: 'Default Options and Escaping'
        markdown: """
    What if someone doesn't provide text in the rendering options? Or worse, what if they provide text containing a cross site scripting attack?
    
    Let's clean this up and add some default options and escaping:
    
    button4.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          }
        };
      });
    ```
    
    > Note that the options object passed into the render call is passed by reference, and will likely be modified. Changes are typically made to this object during rendering, such as the inclusion of default options here.

    The `options` property on the render component specifies default options to be populated if not already present.
    
    The `$z.esc` function provides some useful template escaping functions - in this case we're using the `htmlText`
    filter.

    Now we can try out the edge cases with no options provided:
    ```jslive
      $z.render('@app/button4', document.querySelector('.container-7'));
    ```
    <div class='container-7' style='margin: 20px'></div>
    
    And most importantly, script attacks:
    ```jslive
      $z.render('@app/button4', {
        text: '&lt;script>steal(document.cookie);&lt;/script>'
      }, document.querySelector('.container-8'));
    ```
    <div class='container-8' style='margin: 20px'></div>
    
    So now our component is safe from attacks and no one ever needs to see the output: `undefined`.
    
        """
      ,
        sectionName: 'Escaping Functions'
        markdown: """
    
    The `zest` client library provides `$z.esc`. This can also be loaded separately from the Module ID, `zest/escape`. It provides the following escaping methods:
    
    * **$z.esc(val, 'attr')**: _HTML Attribute escaping. Escapes quotes, ampersands and HTML tags within attributes._
    * **$z.esc(val, 'htmlText')**: _HTML Text escaping. Escapes any HTML tags._
    * **$z.esc(val, 'html', [allowedTagsArray], [allowedAttrArray])**: _Filters HTML to allowed tags and attributes. If not specified,
      allowedTags contains all safe, non-script-injecting tags and similarly for allowedAttr, including HTML5 tags and attributes._
    * **$z.esc(val, 'url')**: _Escapes any `javascript:` urls and performs URI encoding._
    * **$z.esc(val, 'num', [NaNVal])**: _Parses the value as a number, providing the NaNVal if not a number (which is 0 by default)._
    * **$z.esc(val, 'cssAttr')**: _Ensures the value is a single CSS attribute, escaping `:`, `{`, `}` and `"`. Single quotes are not escaped,
      so that using this in a single-quoted HTML style attribute will not be safe. It can only be safely used within a double quoted HTML style attribute tag, such as demonstrated in the [dynamic CSS]() section._

        """
      ,
        sectionName: 'Dynamic Attachment'
        markdown: """

    Render components can be both static and dynamic. For dyanmic interaction, we provide an `attach` module for the render component.

    * The attach property is a moduleID to load the attachment from.
    * The attach module returns a function taking two arguments: `el` and `o`, the DOM element to attach and the options respectively.

    > Note that dynamic render components should always have a single wrapper HTML tag, so that they can be properly
      attached.

    button5.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: './button5-attach'
        };
      });
    ```

    button5-attach.js:
    ```javascript
      define([], function() {
        return function(el, o) {
          el.addEventListener('click', function() {
            alert('click');
          });
        }
      });
    ```
    
    ```jslive
      $z.render('@app/button5', {
        text: 'Click Me!'
      }, document.querySelector('.container-9'));
    ```
    <div class='container-9' style='margin: 20px'></div>

    In this case, `el` is the `<button>` element and `o` is the attachment options.

    #### Mixed Render Components

    Typically attachment should always be a separate module for code clarity and also to be most compatible with server rendering.

    For components that will typically only render on the client, or during prototyping, it is possible to include the attachment in the same file using:

    ```javascript
      attach: function(el, o) {
        // ... attachment ...
      }
    ```

    directly within the render component instead of providing a moduleID string.

        """
      ,
        sectionName: 'Piping Attachment Options'
        markdown: """
  
    The second argument sent to the attach function is the **Attachment Options** object. 

    * By default, the attachment options provided to the attachment function is an empty object. 
    * We need to manually populate the attachment options from the render options by providing a **Pipe Function**.

  As an example, let's provide an option to customize a message when the button is clicked.
    
    button6.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          className: 'MyButton',
          options: {
            text: 'Button',
            msg: 'Message'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          pipe: function(o) {
            return {
              msg: o.msg
            };
          },
          attach: './button6-attach'
        };
      });
    ```

    button6-attach.js:
    ```javascript
      define([], function() {
        return function(els, o) {
          els[0].addEventListener('click', function() {
            alert(o.msg);
          });
        }
      });
    ```
    
    ```jslive
      $z.render('@app/button6', {
        text: 'Msg Button',
        msg: 'Its a message'
      }, document.querySelector('.container-10'));
    ```
    <div class='container-10' style='margin: 20px'></div>
    
    The benefit of pipe, is that when we render a component on the server, we don't need to send down all the data that was used
    to perform the rendering to the client - we only send the attachment options that we want to pipe to the client. Consider a gallery
    component that renders images from raw image data, there is no reason to send all this raw JSON image data to the client once its been generated
    into HTML.

    ### Pipe Shorthands

    It can be a little laborious typing out the pipe function, so there are a couple of helpers:

    1. When wanting to specify specific properties to pipe directly, pipe can be set to an array of properties to pipe:

      ```javascript
      {
        pipe: ['property', 'sub.property', 'items.*.title']
      }
      ```

    2. When writing components for client rendering only, setting `pipe: true` will pipe all options by default.


    #### Next Steps

    We will come back to this button example shortly to demonstrate [Controller Attachment](#Attaching%20Controllers). But first we will cover creating hierarchies of components using **Regions**.

        """
      ,
        sectionName: 'Regions'
        markdown: """
    Any template can define a named region using the syntax <code>{&#96;RegionName&#96;}</code>. 

    For example, we can create a dialog render component, permitting any content:

    dialog1.js:
    ```javascript
      define(['css!./dialog'], function() {
        return {
          className: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;/div>"
        };
      });
    ```
    
    dialog.css:
    ```css
      .SimpleDialog {
        background-color: #fff;
        padding: 20px;
        margin: 50px;
        border: 1px solid #ccc;
        /* etc... */
      }
    ```

    We can populate the region by providing the region name option property for rendering.

    ```jslive
      $z.render('@app/dialog1', {
        content: '&lt;p>some content&lt;/p>'
      }, document.querySelector('.container-11'));
    ```
    <div class='container-11' style='margin: 20px'></div>

    The region value can be any render structure, which is simply passed to an internal `zest.render` call.

        """
      ,
        sectionName: 'Private Regions'
        markdown: """

    Setting the region property directly on the render component object will take preference over the region in the options, allowing for **Private Regions**.
    
    We can use this to render a dialog that contains a button.
    
    dialog2.js:
    ```javascript
      define(['./button6', 'css!./dialog'], function(Button) {
        return {
          className: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;div class='button'>{&#96;button&#96;}&lt;/div>&lt;/div>",
          button: Button
        };
      });
    ```

    In this case, the button is assumed to be in the same folder as the dialog for portability.
    
    ```jslive
      $z.render('@app/dialog2', {
        content: '&lt;p>some content&lt;/p>'
      }, document.querySelector('.container-12'));
    ```
    <div class='container-12' style='margin: 20px'></div>
        

    In this way, we can build up complex render components from simple render component parts,
    all of which can still be rendered by a single render call.
    
    An entire page can be a render component, allowing it to be modular, rendered on both the client or server and including natural build support.
        
        """
      ,
        sectionName: 'Dynamic Regions'
        markdown: """

    Often the component options need to be processed before being rendered by the template function. It is best to move any data-processing code
    into the load function in this case.

    The load function is a hook on any render component, taking the following forms (this is the last hook - there are only 7 in total):

    ```javascript
      // 1. synchronous
      load: function(o) { ... }

      // 2. asynchronous
      load: function(o, done) { ... done() }
    ```

    Consider a component which renders a list of buttons:

    button-list.js
    ```javascript
      define(['./button6'], function(Button) {
        return {
          options: {
            buttonList: ['default', 'buttons']
          },
          load: function(o) {
            o.listStructure = o.buttonList.map(function(title) {
              return {
                render: Button,
                options: {
                  text: title,
                  msg: 'clicked ' + title
                }
              };
            });
          },
          render: function(o) {
            return "&lt;div>{&#96;listStructure&#96;}&lt;/div>"
          }
        };
      });
    ```

    We map the options data into a render structure (an array of render structures being an allowed render structure itself),
    which is then stored as a dynamically generated region on the options object, before being rendered.
    
    ```jslive
      $z.render('@app/button-list', {
        buttonList: ['here', 'are', 'some', 'buttons']
      }, document.querySelector('.container-13'));
    ```
    <div class='container-13' style='margin: 20px'></div>

    Note that when rendering lists where each item has mouse events or attachments, it is often better for performance for the list component 
    itself to handle the  attachment through a single event handler delegate, than having individual attachments for each sub-component.

    `$z.render` should never be called within the render cycle - regions should always be used for sub-rendering. `$z.render` can be used
    in component attachment functions as part of client-side dynamic rendering though.

        """
      ,
        sectionName: 'Render Structures'
        markdown: """

    As mentioned in the first section, there are 5 **Render Structures** that can be rendered by `zest.render` or through regions on both the client and server. All render structures accept a render options object. When no options are provided, an empty options object is used. 

    The render structures are:

    * **Module ID, String**: _A string prefixed with `@` indicating a RequireJS Module ID to load the render structure from._
    * **HTML, String**: _A string of HTML to render, supporting regions with the syntax <code>{&#96;RegionName&#96;}</code> from the render options._
    * **Render Component, Object**: _An object with a `render` property. It can have default options (`options`), a type name (`type`), an attachment function (`attach`), attachment options generation (`pipe`) as well as public and private region support._
    * **Render Function, Function**: _A function that returns another render structure, with one argument containing the render options. The returned structure is rendered with an empty options object._
    * **Render Array, Array**: _An array of render structures to render one after another. Useful for regions with multiple items. Each render structure is rendered with a clone of the options provided to the array render._

    By combining the rules above, rendering becomes a process of managing information flow from the top of the component hierarchy down to the bottom, working naturally with the JavaScript language.

        """
      ,
        sectionName: 'Information Flow'
        markdown: """

    Typically the parent component is provided all the necessary data from the initial render call. It is then responsible for passing its data down to its direct children, who can in turn pass their data on.

    Lets demonstrate this with the dialog component, by allowing the button text to be customized as a dialog
    option.

    dialog3.js:
    ```javascript
      define(['./button6', 'css!./dialog'], function(Button) {
        return {
          className: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;div class='button'>{&#96;button&#96;}&lt;/div>&lt;/div>",
          button: function(o) {
            return {
              render: Button,
              options: {
                text: o.confirmText,
              }
            };
          }
        };
      });
    ```

    The `button` region is a render function, taking the dialog options object as its argument. It then returns
    a render component, which renders the button with the text from the `confirmText` dialog option.

    > The dialog could have provided a default option for the confirmText property, but the button default value will apply anyway. Remove the confirmText property in the example to try this.

    ```jslive
      $z.render('@app/dialog3', {
        confirmText: 'Ok',
        content: '&lt;p>some content&lt;/p>'
      }, document.querySelector('.container-14'));
    ```
    <div class='container-14' style='margin: 20px'></div>

    This is the standard pattern for populating a region, using a region render function to pass the options down
    to the child render.

    ### Instance Rendering

    When we render the button in the dialog, we are effectively rendering the structure:

    ```jslive
      $z.render({
        render: '@app/button6',
        options: {
          text: 'Ok'
        }
      }, document.querySelector('.container-15'));
    ```
    <div class='container-15' style='margin: 20px'></div>

    The above **Instance Render** allows us to specify a structure to render and with what options.

    The instance render is actually just a render component variation. In both of the above cases, it is rendered with an empty options object, which then has its default options set from the `options` property (like any other render component) so that the options become a clone of the default options. This cloned options object is then passed to the child render call for the button.

    For regions with multiple items, we can return an array of instance renders from the render function on the region,
    each with their own mapped options.

    ***
          """
      ,
        sectionName: 'Attaching Controllers'
        markdown: """

    To be able to communicate with the button component we need a controller object for the button.

    * The controller forms a public interface, allowing for the button to provide methods, properties and events.
    * The controller is just a JavaScript object, and the interface is whatever is put on that object.
    
    **The return value of the `attach` function is the controller for that render component.**
    
    For example, we can add a controller to the button with a click event hook. The previous popup message and pipe
    function have been removed.

    button7.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: './button7-controller'
        };
      });
    ```

    button7-controller.js:
    ```javascript
      define(['zest'], function($z) {
        return function(el, o) {
          var clickEvent = $z.fn();
          el.addEventListener('click', clickEvent);
          
          return {
            click: clickEvent
          };
        }
      });
    ```

    The button controller returned from the attach function provides a single property, `click`, which can be used to attach click event handlers to the button by writing:

    ```jslive
      $z.render('@app/button7', {
        text: 'controller button'
      }, document.querySelector('.container-16'), function(ButtonController) {
        ButtonController.click.on(function() {
          // custom click event handler
          alert('button click')
        });
      });
    ```
    <div class='container-16' style='margin: 20px'></div>

    The render completion callback only provides the controller from the initial renderable passed into `$z.render`. If we had rendered a list
    of buttons, we wouldn't have had the reference to the individual button controllers.

    In order to get a reference to any controller, we can use **Component Selection**.


    ### zoe.fn - Event Chains

    The `$z.fn()` generator is provided by zoe.js as `zoe.fn()`, which comes bundled with Zest (although it can be replaced with an alternative event model if required).

    To demonstrate the use of `zoe.fn`:

    > The [full documentation for zoe.fn](http://zoejs.org#zoe.fn) can be found on the zoe.js website.

    ```jslive
      // create the function chain
      var myClickEvent = $z.fn();

      // attach some functions
      myClickEvent.on(function() {
        alert('its an event handler');
      });
      myClickEvent.first(function() {
        alert('this happens first');
      });
      myClickEvent.on(function() {
        alert('"this" scope is ' + this);
      });

      // bind the 'this' scope
      myClickEvent.bind('hello');

      // fire the chain
      myClickEvent();
    ```

    It makes for a simple eventing model, where the functon is the event trigger and listeners are added with the `on` method.

        """
      ,
        sectionName: 'Component Selection'
        markdown: """

    Zest registers all dynamic components under their unique ID, which matches the HTML ID.
    
    The component selector is identical to a standard DOM selector, except that whenever an element is matched that is a render component
    with a controller, the controller is returned instead of the DOM element.

    The selector functions are:

    ```javascript
      $z.select(selectorString, context, callback);
    ```
    and
    ```javascript
      $z.selectAll(selectorString, context, callback);
    ```

    * **selectorString**: _Identical to a standard query selector._
    * **context**, (optional): _An optional container DOM element within which to do the selection._
    * **callback**, (optional): _Optionally when rendering on the server and the component has **progressive
        enhancement** enabled, this allows a callback to be fired once the attachment has been done. 
        This is only necessary for components with the `progressive` property set to true, but will work for all component selection._

    As a shortcut to `$z.selectAll`, `$z` is an alias to this selector function.
        
    For example, we can create a button with a given ID and then use the component selector to get its controller:
    
    ```jslive
      $z.render('@app/button7', {
        id: 'button7',
        text: 'Button 7'
      }, document.querySelector('.container-17'), function() {
      
        $z.select('#button7').click.on(function() {
          alert('hooked click!');
        });
        
      });
    ```
    <div class='container-17' style='margin: 20px'></div>
    
    Note that because rendering is asynchronous, we've put the interaction code in the complete callback for the render function to ensure that rendering is completed before we run the component selector.

        """
      ,
        sectionName: 'Asynchronous Attachment'
        markdown: """

    When we render a component on the server, we need to decide if we want to block the page until it
    has fully loaded its dynamic attachment scripts, or if we want to continue displaying the page and then 
    **progressively enhance** the component once its scripts have completed loading asychronously with RequireJS.

    By default, the attachment for a component rendered on the server will block the HTML page render stream until the dynamic component has been fully attached. 
    This is to ensure synchronous component selectors will behave as expected between client and server.

    To indicate that a component should be progressively enhanced with asynchronous attachment, set the `progressive`
    property on the render component:

    ```javascript
    define(['./WidgetTemplate'], function(WidgetTemplate) {
      return {
        className: 'ProgressiveWidget'
        render: WidgetTemplate,
        attach: './WidgetAttachment',
        progressive: true
      };
    });
    ```

    Other components or scripts needing access to the component controller will then need to use asynchronous component
    selection in case the component is still being attached.

    parent-widget-attach.js (for example):
    ```javascript
    define([], function() {
      return function(el, o) {
        $z.select('> .ProgressiveWidget', el, function(EnhancedWidgetController) {
          // now we know the controller for the child component, 
          // ProgressiveWidget has been attached
        });
      }
    })
    ```

    If the component has already been attached, the callback will trigger immediately. The selector still requires the HTML
    to be present in the page before it will work. This is ensured naturally for any parent component as its attachment
    will come after any child component in the HTML.

    [Read more about the server load process here](#Server%20Rendering%20Mechanics).

        """
      ,
        sectionName: 'Disposal'
        markdown: """
        
    The controller can have any properties at all. The only methods that Zest makes assumptions about are the 
    **dispose** and **init** methods. If the `dispose` method exists, this method is called when the element is disposed.
    
    We can add a dispose method to the button controller to correctly detach our events to prevent memory leaks.

    button8-controller.js (button8.js identical to button7.js):
    ```javascript
      define(['zest'], function($z) {
        return function(el, o) {
          var clickEvent = $z.fn();
          el.addEventListener('click', clickEvent);
          
          return {
            click: clickEvent,
            dispose: function() {
              el.removeEventListener('click', clickEvent);
            }
          };
        }
      });
    ```
    
    The `dispose` method on the controller is updated so that we can call it to run the entire disposal:
    
    ```jslive
      $z.render('@app/button8', {
        id: 'button8a',
        text: 'Dispose Me'
      }, document.querySelector('.container-18'), function() {
      
        var button8a = $z.select('#button8a');
        button8a.click.on(function() {
          button8a.dispose();
        })
        
      });
    ```
    <div class='container-18' style='margin: 20px'></div>
    
    There is also a global dispose method, `$z.dispose` which can be called on any DOM element or element collection to find and dispose all components within that HTML, including running their disposal hooks:
    ```jslive
      $z.render('@app/button8', {
        id: 'button8b',
        text: 'Dispose Me'
      }, document.querySelector('.container-19'), function() {
      
        $z.select('#button8b').click.on(function() {
          $z.dispose(document.querySelector('.container-19').childNodes);
        });
        
      });
    ```
    
    <div class='container-19' style='margin: 20px'></div>
        """
      ,
        sectionName: 'Controller Communication'
        markdown: """

    We can now hook the button click method from the dialog component to close the dialog when the button is clicked:
    
    dialog4.js:
    ```javascript
      define(['./button8', 'css!./dialog'], function(Button) {
        return {
          className: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;div class='button'>{&#96;button&#96;}&lt;/div>&lt;/div>",
          button: function(o) {
            return {
              render: Button,
              options: {
                text: o.confirmText,
              }
            };
          },
          attach: './dialog4-attach'
        };
      });
    ```

    dialog4-attach.js:
    ```javascript
      define(['zest'], function($z) {
        return function(el, o) {
          var MyButton = $z.select('> .button .MyButton', el);
          MyButton.click.on(function() {
            $z.dispose(el);
          });
        }
      });
    ```
    
    And see it in action:
    ```jslive
      $z.render('@app/dialog4', {
        content: '&lt;p>content&lt;/p>',
        confirmText: 'Ok'
      }, document.querySelector('.container-20'));
    ```
    <div class='container-20' style='margin: 20px'></div>

    We use the component selector, contextualized to the dialog component. 

    **The initial direct child selector (`>`) allows us to ensure we select direct children of the master component element only, and not some other `.button` contained within the content region. Ensuring selectors are well-defined is important for component modularity and portability.**
    
    ***
        """
      ,
        sectionName: 'DOM Selectors'
        markdown: """

    Typically, the first things an attachment function will do is select components and elements within the component to attach its dynamic functionality to.

    To select components, we use the component selector from the previous section.

    To select elements, we use the standard query selector.

    Zest provides a cross-browser compatible selector shortcut at `$z.$`:

    ```javascript
      $z.$(selector, context);
    ```

    This supports the leading direct child selector (`>`, as demonstrated with the component selector) for direct selection within containers
    ensuring well-defined selection modularity.

    The cross-browser behavior is provided by the RequireJS [selector module](https://github.com/guybedford/selector). It will:

    1. Check for CSS3 support with the native query selector.
    2. If compatible, the native query selector is used.
    3. If not compatible, Sizzle will be download from CDN dynamically.

    If using your own library which provides a selector engine, direct Zest to this selector with the configuration:

    ```javascript
    {
      map: {
        '*': {
          selector: 'jquery'
        }
      }
    }
    ```

    `$z.$` will then reference jQuery, and `jQuery` can also be loaded directly.
        """
      ,
        sectionName: 'Adding jQuery'
        markdown: """
    
    An easy way to install jQuery is with Volo - just type the following from the base project folder:
    ```
      volo add jquery
    ```
    
    Next we add the selector configuration from the previous section into our RequireJS configuration.

    Then just include jQuery as a RequireJS dependency to the components that need it:
    
    button9-controller.js (button9.js as expected):
    ```javascript
      define(['zest', 'jquery'], function($z, $) {
        return function(el, o) {
          var clickEvent = $z.fn();
          $(el).click(clickEvent);
          
          return {
            click: clickEvent,
            dispose: function() {
              $(el).unbind();
            }
          };
        }
      });
    ```
    
    And just to prove it works:
    ```jslive
      $z.render('@app/button9', {
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-21'), function(Button) {
        Button.click.on(function() {
          Button.dispose();
        });
      });
    ```
    <div class='container-21' style='margin: 20px'></div>

        
    ### Converting jQuery Plugins into Render Components
    
    It is straightforward to convert jQuery plugins to work with Zest rendering by loading the plugin as a dependency.
    
    The CSS and HTML template get gathered together as the render component. What would have been a 'domready' or 'attachment' code becomes this attachment module, and the standard plugin controller can be returned.
    
    Most plugins aren't designed for AMD environments - for these needs, use the [RequireJS shim config](http://requirejs.org/docs/api.html#config-shim) to tell RequireJS how to load the plugin, and what global it defines.
        
        """
      ,
        sectionName: 'Loading Data'
        markdown: """
        
    Up until now we've assumed that all data for rendering is provided with the initial render call. This is a good way to go about
    things in most cases, but it is also possible for components to do their own loading.

    We can do this using the asynchronous version of the [`load`](#Dynamic%20Regions) function.
        
    > To install [http-amd](https://github.com/guybedford/http-amd) with Volo, use `volo add guybedford/http-amd`.

    The asynchronous load is very useful when combined with the an HTTP module like [http-amd](https://github.com/guybedford/http-amd). This provides an HTTP implementation which works with the same API on both the browser and the server.
    
    As a very rough example, consider a component which uses a local server service to load data:
    
    ```javascript
      define(['http-amd/json'], function(json) {
        return {
          options: {
            dataUrl: '/products'
          },
          load: function(o, done) {
            json.get(o.dataUrl, function(data) {
              o.productList = data.products;
              done();
            }, function(err) {
              o.error = 'Error loading products!';
              done();
            });
          },
          render: function(o) {
            //render from o.productList data, including error handling render
          }
        }
      });
    ```
    
    This allows for components to load data as part of their rendering cycle, regardless of whether they load on the client or server.
        
        """
      ,
        sectionName: 'Global Render Options'
        markdown: """
        
    There are situations where global options may need to be shared between all components during the render, such as the URL of the server in the previous load example.
    
    There is a reserved property on the options object that can be used for this - `options.global`.
    
    This global object property on the options is included in every render options object by reference. This allows for global settings to be communicated down the whole render chain.

    The global options can be set with the initial render options. The pipe function can also be used to populate the global options that should be piped to the client.
        
        """
      ,        
        sectionName: 'CoffeeScript Components'
        markdown: """
    
    > To install the [CoffeeScript plugin](https://github.com/jrburke/require-cs) to write CoffeeScript modules, use `volo add jrburke/require-cs`.

    CoffeeScript makes render components much easier to work with, as cumbersome return calls and curly braces can be omitted. The multi-line string support with interpolation makes the templates easier to write, and the code looks nicer in general.
    
    button.coffee:
    ```coffeescript
      define ['zest', 'css!./button'], ($z) ->
        className: 'MyButton'
        options:
          text: 'Button'
        render: (o) -> "&lt;button>&#35;{$z.esc(o.text, 'htmlText')}&lt;/button>"
        attach: 'cs!./button-controller'
    ```

    button-controller.coffee:
    ```coffeescript
      define ['jquery'], ($) ->
        return (el, o) ->
          clickEvent = $z.fn()
          $(el).click clickEvent

          return {
            click: clickEvent
            dispose: -> 
              $(el).unbind()
          }
    ```
    
    dialog5.coffee:
    ```coffeescript
      define ['cs!./button', 'css!./dialog'], (Button) ->
        className: 'SimpleDialog'
        render: &quot;&quot;&quot;
          &lt;div>
            {&#96;content&#96;}
            &lt;div class='button'>{&#96;button&#96;}&lt;/div>
          &lt;/div>
        &quot;&quot;&quot;

        button: (o) ->
          render: Button
          options:
            text: o.confirmText

        attach: 'cs!./dialog5-attach.coffee'
    ```

    dialog5-attach.coffee:
    ```coffeescript
      define [], () ->
        return (el, o) ->
          MyButton = $z.select '>.button MyButton', el
          MyButton.click.on -> $z.dispose el
          return null # no controller
    ```

        
    With the RequireJS CoffeeScript plugin we simply add the `cs!` prefix to the module ID:
    
    ```jslive
      $z.render('@cs!app/dialog5', {
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-22'));
    ```
    <div class='container-22' style='margin: 20px'></div>

    ***
        """
      ,
        sectionName: 'Dynamic CSS'
        markdown: """
        
    Often it can be useful to define dynamic CSS styles on an element. In the case of the dialog, the width and height could be options for rendering.
    
    Since this is only being used for dynamic instance-specific CSS, this is exactly the sort of situation inline styles are designed for.

    Zest provides a helper on render components for inline styles, with the `style` property.
    
    We must always ensure that we correctly escape the CSS taken from options, either using the `cssAttr` or `num` escaping methods.
    
    This style property is demonstrated with CoffeeScript, because it is much neater than the JavaScript equivalent. In JavaScript,
    the `style` string could be imported from a separate text file using the RequireJS text plugin.
    
    dialog6.coffee:
    ```coffeescript
      define ['zest', 'cs!./button', 'css!./dialog'], ($z, Button) ->
        className: 'SimpleDialog'
        options:
          width: 400
          height: 300

        render: (o) -> &quot;&quot;&quot;
          &lt;div>
            {&#96;content&#96;}
            &lt;div class='button'>{&#96;button&#96;}&lt;/div>
          &lt;/div>
        &quot;&quot;&quot;

        style: (o) -> &quot;&quot;&quot;
          &#35;&#35;{o.id} {
            width: &#35;{$z.esc(o.width, 'num', @options.width)}px;
            height: &#35;{$z.esc(o.height, 'num', @options.height)}px;
          }
        &quot;&quot;&quot;
        
        button: (o) ->
          render: Button
          options:
            text: o.confirmText

        attach: 'cs!./dialog5-attach'
    ```
    
    Notice the use of the third escaping argument, `@options.width`. This is the equivalent of writing `this.options.width` in JavaScript. We are
    passing the default options width from the component into the escaping function, so that if the value is not a number, the default
    can still be used.
    
    ```jslive
      $z.render('@cs!app/dialog6', {
        width: 'asdf',
        height: 300,
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-23'));
    ```
    <div class='container-23' style='margin: 20px'></div>

    The `style` property should only ever be used for dynamic CSS. All other CSS should be in a separate CSS file for production use.
    
        """
      ,
        sectionName: 'Querying the Layout'
        markdown: """

    Often attachment scripts need to calculate the size or position of elements in the DOM layout in order to properly generate a dynamic
    interaction.

    When rendering on the client, attachment is done entirely outside of the DOM first. Outside of the DOM, events and selectors can all be attached
    fine, but any layout-based information will be incorrect. This is in order to avoid unnecessary render cycles.

    For this reason, a controller can provide an `init` method, which will be called on injection into the DOM.

    As an example, we can query the dialog size in its attachment:

    dialog7-attach.coffee (dialog7.coffee as in dialog6.coffee):
    ```coffeescript
      define [], () ->
        return (el, o) ->
          MyButton = $z.select '>.button MyButton', el
          MyButton.click.on -> $z.dispose el

          alert('height outside DOM: ' + el.offsetHeight)
          return {
            init: ->
              alert('height in DOM: ' + el.offsetHeight)
          }
    ```
    ```jslive
      $z.render('@cs!app/dialog7', {
        height: 600,
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-24'));
    ```
    <div class='container-24' style='margin: 20px'></div>

        """
      ,
        sectionName: 'Sharing and Packaging Components'
        markdown: """

    To share our component, we can create an archive containing our project files just for that component:

    ```
      -dialog.js
      -dialog-attach.js
      -button.js
      -button-controller.js
      -button.css
      -dialog.css
      -package.json
    ```

    There are then a number of different ways to use package-management to share the component.

    The most simple is purely to upload this directly to GitHub and then allow others to download the archive.

    Since all the files are written with relative dependencies, it is entirely portable and can be loaded from any folder.

    ### Volo

    To share the component with Volo, we'd typically add a list of dependencies to our `package.json`. The dependencies
    we have are `jquery` and `zest`. So we can write that as:

    package.json:
    ```javascript
    {
      "name": "button-and-dialog",
      "version": "0.0.1",
      "volo": {
        "dependencies": {
          "zest": "zestjs/zest",
          "jquery": "jquery"
        }
      }
    }
    ```

    That's all we need to do. Now anyone can type the following from their project root:

    ```
      volo add your_github_name/button-and-dialog
    ```

    And it would install a folder `button-and-dialog` into their library folder, and also download jQuery and zest.

    They would then be able to render the dialog from the module ID, `cs!button-and-dialog/dialog`.

    There are a variety of package managers available to use. For example, you could also use [Bower](https://github.com/twitter/bower). 

    ### Next Steps

    The next chapter covers the eventing model in more detail and how to create components that can be extended. 

    There's no need to read the chapters in order. Feel free to jump to the [Server Rendering](#Zest%20Server) chapter to render these components on the server, or the [Building](#Building) chapter to optimize the site for production.

        """
      ]
    ,
      chapterName: 'Creating Extensible Components'
      sections: [
        sectionName: 'Zest Object Extension'
        markdown: """

    Zest Object Extension ([zoe.js](http://zoejs.org)) is provided as a separate library and can be used optionally. By default it is loaded with the `zest` module, and the `zoe` methods are copied over onto the `$z` object for convenience.

    zoe.js provides a natural JavaScript inheritance framework that was designed for the dynamic controller interactions in Zest.

    The idea is that render component controllers should use extensible prototype inheritance.

    In this way, render components can be extended - an abstract slideshow render component and controller can be extended into a more specific slideshow with a toolbar and colour scheme.

    The inheritance model is based on three functions:

    * [**zoe.fn**](http://zoejs.org/#zoe.fn): _Generates a function chain event instance. Used for eventing and many other purposes as well._
    * [**zoe.extend**](http://zoejs.org/#zoe.extend): _Extends a host object with properties from a new object. Uses extension rules to provide 
      different extension for different properties._
    * [**zoe.create**](http://zoejs.org/#zoe.create): _The inheritance model. Creates a class instance from a definition, using the object extension system with some hooks._

    For component controllers, the zoe.js inheritor [`$z.Component`](#$z.Component) is provided to easily create dynamic render components.

    If you prefer not to use this object model, this section still includes some useful patterns for object extension regardless of the underlying model.

        """
      ,
        sectionName: 'Controller Constructors'
        markdown: """

    Consider the controller pattern in the `attach` function we've been using up until now for the button:

    button-controller.js:
    ```javascript
      define([], function() {
        return function(el, o) {
          var clickEvent = $z.fn();
          $(el).click(clickEvent);
          
          return {
            click: clickEvent,
            dispose: function() {
              $(el).unbind();
            }
          };
        }
      });
    ```

    The controller is **implicitly** defined by the return function. It is hidden away, with no way for us to extend this button component into anything more than the `click` and `dispose` events as above.

    Additionally, every single controller is a new object, with new functions. There is no memory-sharing between instances of the same controller.

    We can solve both of the above by providing a **Controller Constructor** function, a standard JavaScript object constructor, as the `attach` method.

    ```javascript
      define(['zest', 'jquery'], function($z, $) {
        var attach = function(el, o) {
          this.$button = $(el);
          this.click = $z.fn();

          this.$button.click(this.click);
        }
        attach.prototype.dispose = function() {
          this.$button.unbind();
        }
        return attach;
      });
    ```

    The constructor is then instantiated by the natural running of the `attach` method.

    It's not a massive saving for now, but we've opened up the controller prototype so that the button can be extended, and we're also sharing the same dispose function between multiple buttons on the same page.

    There is a minor issue with the above - we are writing a procedural definition. In order to allow for the nicer looking object definitions we've been using up until now, we need some class sugar.

        """
      ,
        sectionName: 'Object Constructor Sugar'
        markdown: """

    There are many different libraries providing class sugar in JavaScript. zoe.js comes with one model based on object extension. We demonstrate it here, but you can replace this with any other as well.

    To use the object constructor, we extend from the base `zoe.Constructor` class, using the extension function `zoe.create`. This allows us to explicitly write our `constructor` and `prototype` properties in the object definition to get our sugar-coated class.

    > Read more about `zoe.create` and `zoe.Constructor` in the [zoe documentation](https://zoejs.org).

    button10.js (exactly from button7.js):
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: './button10-controller'
        };
      });
    ```

    button10-controller.js:
    ```javascript
      define(['zest', 'jquery'], function($z, $) {
        return $z.create([$z.Constructor], {
          construct: function(el, o) {
            this.$button = $(el);
            this.click = $z.fn();

            this.$button.click(this.click);
          },
          prototype: {
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```

    ```jslive
      $z.render('@app/button10', {
        text: 'Ok'
      }, document.querySelector('.container-26'));
    ```
    <div class='container-26' style='margin: 20px'></div>

    We've thus created an **explicit** definition of our component, making code much easier to read.

        """
      ,
        sectionName: 'Events and Binding'
        markdown: """

    The event handler provided by `zoe.fn` supports the `bind` method allowing us to bind the `this` scope of the click
    callback function to the controller.

    We can then write:

    ```javascript
      define(['zest', 'jquery'], function($z, $) {
        return $z.create([$z.Constructor], {
          construct: function(el, o) {
            this.$button = $(el);
            
            // bind the event to the controller
            this.click = $z.fn().bind(this);

            this.$button.click(this.click);
          },
          prototype: {
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```

    Now the `this` reference of the click event will always be the controller.

    #### zoe.fn Initial Functions

    If we wanted the button to come with some click handler functions already provided, we can add initial event listeners into our `zoe.fn` method:

    ```javascript
      define(['zest', 'jquery'], function($z, $) {
        return $z.create([$z.Constructor], {
          construct: function(el, o) {
            this.$button = $(el);
            
            // create an event chain, add the base click function, bind it to the controller
            this.click = $z.fn().on(this.click).bind(this);
            
            this.$button.click(this.click);
          },
          prototype: {
            dispose: function() {
              this.$button.unbind();
            }
            // base click function, shared between all buttons
            click: function() {
            }
          }
        });
      });
    ```

    #### Event Sugar

    Since the above line of `this.event = $z.fn().on(this.baseEvent).bind(this)` is common to all events, we can sugar this to save typing.

    This is provided by the zoe inheritor, `$z.InstanceEvents`.

    We supply an `_events` array, and these items will then have the above common operation automatically performed for us:

    button11-controller.js (button11.js as expected):
    ```javascript
      define(['zest', 'jquery'], function($z) {
        return $z.create([$z.Constructor, $z.InstanceEvents], {
          _events: ['click'],
          construct: function(el, o) {
            this.$button = $(el);

            // click event already created on the instance and bound to the controller, 
            // including the base click event.
            this.$button.click(this.click);
          },
          prototype: {
            // base click function for all instances (optional)
            click: function() {
              alert('base click event');
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```
    ```jslive
      $z.render('@app/button11', {
        text: 'Ok'
      }, document.querySelector('.container-27'), function(Button) {

        Button.click.on(function() {
          alert('instance-specific click event');
        })

      });
    ```
    <div class='container-27' style='margin: 20px'></div>

        """
      ,
        sectionName: 'Extending Components'
        markdown: """

    Component extension at its core is basically cloning the component object, and modifying some of the properties:

    button12.js:
    ```javascript
      define(['zest', './button11'], function($z, Button) {
        return $z.create([Button], {
          _extend: {
            'attach': 'REPLACE'
          },
          pipe: ['text'],
          attach: './button12-controller'
        });
      });
    ```

    * `$z.create` creates a new object, then extends it with the button render component properties, then finally extends it with the definition object above.
    * The definition object just contains the `pipe` and `attach` properties.
    * Since there is already an attach property, we need to provide an override rule.
    * We use the `_extend` object to specify our rules - matching the `attach` method to the replace rule.

    We thus get an object contaning the render component properties from button11.js, but with the new properties added.
    At its core, we are simply applying object extension with rules, provided by zoe.js.

    We then do the same thing for the controllers:

    button12-controller.js:
    ```javascript
      define(['zest', './button11-controller'], function($z, ButtonController) {
        return $z.create([ButtonController], {
          _events: ['hoverIn', 'hoverOut'],
          construct: function(el, o) {
            this.text = o.text;
            this.$button.bind('mouseenter', this.hoverIn);
            this.$button.bind('mouseleave', this.hoverOut);
          },
          prototype: {
            hoverIn: function() {
              this.$button.text('Hovering!');
            },
            hoverOut: function() {
              this.$button.text(this.text);
            }
          }
        });
      });
    ```

    We can add the new `_events` because `$z.InstanceEvents` is already provided by ButtonController.

    ```jslive
      $z.render('@app/button12', {
        text: 'Ok'
      }, document.querySelector('.container-28'));
    ```
    <div class='container-28' style='margin: 20px'></div>

    We've been able to:

    * Extend the render component, adding an extra pipe property to access the `text` option from the attachment.
    * Add two new events, which extended the existing event.
    * Add an extra constructor to run after the base constructor, binding our new events.
    * Add two new methods on the prototype shared between all instances.

    The idea with zoe.js is that all of these properties are extended naturally as expected as much as possible.

    We could also have included some extra CSS (and added a className to append the classes) or included other dependencies as part of the extension. 
    Because the button is a dependency, we can still build the extended button into a single file, with full dependency tracing from the r.js optimizer.

        """
      ,
        sectionName: 'Custom Extension Rules'
        markdown: """

    The extension rules don't do anything magical, they are simply functions of two properties returning a new property and are located at `$z.extend.RULE_NAME`.

    The `$z.Constructor` and `$z.InstanceEvents` provide their own rules for the `construct`, `prototype` and `_events` properties in the background, which
    is how they combine as we'd like.

    We can also provide custom rules for our own properties. Let's demonstrate by re-extending the hover button:

    button13.js:
    ```javascript
      define(['zest', './button12'], function($z, ButtonHover) {
        return $z.create([ButtonHover], {
          _extend: {
            options: 'EXTEND',
            pipe: 'ARR_APPEND'
          },
          options: {
            doHover: true
          },
          pipe: ['doHover'],
          attach: './button13-controller'
        });
      });
    ```

    Note that we don't need to specify that the `attach` property should be replaced again. This is because it has already been
    declared a property for replacement by the `ButtonHover` `_extend` rules.

    button13-controller.js:
    ```javascript
      define(['./button12-controller'], function(ButtonHoverController) {
        return $z.create([ButtonHoverController], {
          _extend: {
            'prototype.hoverIn': 'REPLACE'
          },
          construct: function(el, o) {
            this.doHover = o.doHover;
          },
          prototype: {
            hoverIn: function() {
              if (this.doHover)
                this.$button.text('Hovering!');
            }
          }
        });
      });
    ```

    ```jslive
      $z.render([{
        render: '@app/button13',
        options: {
          text: 'Hover Button'
        }
      },
      {
        render: '@app/button13',
        options: {
          text: 'Non-hover button',
          doHover: false
        }
      }], document.querySelector('.container-29'));
    ```
    <div class='container-29' style='margin: 20px'></div>

    With the above extension, we have:

    * Extended the `options` and `pipe` render component properties to provide the `doHover` option.
    * In our constructor, we store this property on the instance for reference.
    * We then override the `hoverIn` function using an extension rule.
    * The overrided hover function then allows us to check if we want to provide hover support before doing anything.

    This is mainly an illustrative example to see the power of extension rules.

    Getting extension right is quite an advanced concept, and isn't necessary for small projects, but it is an important aspect of reusability.

    To read more about extension rules, see the [extension section of the zoe.js documentation](http://zoejs.org/#zoe.extend).
        """
      ,
        sectionName: '$z.Component'
        markdown: """

    `$z.Component` brings together the concepts of this chapter into a single inheritor. It allows for a standard definition form when writing
    extensible components to be used by both the render component and attachment modules.

    It provides:

    * Controllers as constructors - just provide the `construct` and `prototype` properties.
    * `zoe.InstanceEvents` for automatic eventing through the `_event` property.
    * Standard extension rules the render component properties (className, options, load, pipe).
    * Contextual DOM and component selectors on the controller prototype (`this.$` and `this.$z`).
    * Automatic copying of the `el` and `o` parameters from the constructor to the instance (`this.el` and `this.o`).

    button14.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return $z.create([$z.Component], {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: './button14-controller'
        });
      });
    ```

    button14-controller.js:
    ```javascript
      define(['jquery'], function($) {
        return $z.create([$z.Component], {
          _events: ['click'],
          construct: function(el, o) {
            this.$button = $(el);
            this.$button.click(this.click);
          },
          prototype: {
            click: function() {
              alert('a prototype event function');
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```

    With the above definition of Button, we wouldn't have needed to provide extension rules for `pipe`, `options` and `attach` as we did in the previous section.

    We only need to include `_extend` rules for properties we define, which is the general principle with `_extend` rules, unless performing an override.

    ```jslive
      $z.render('@app/button14', {
        text: 'Ok'
      }, document.querySelector('.container-30'));
    ```
    <div class='container-30' style='margin: 20px'></div>

    #### Contextual Selectors

    The prototype has two contextual selectors defined:

    ```javascript
      this.$(querySelector)
      this.$z(componentSelector)
    ```

    These selectors are restricted to within the containing element of the component and both support the leading direct child selector (`>`) so that selectors can be carefully written to be exactly scoped to the component regardless of the contents of their regions.

    Typically one can implement `$z.Component` when it suits, and follow the basic patterns here without worrying too much about the implementation details.

    If you are looking to provide extensible component parts and base classes and want to use `zoe` as
    the inheritance system then read more about it at the [ZOE documentation page](http://zoejs.org/).

        """
      ,
        sectionName: 'Mixed Render Components'
        markdown: """

    There is a shortcut we can do when defining components, and that is to write the entire component as a single object, without a separate attach module.

    **This can be useful for components that render on the client only.** 

    For components that render on the server, one should always have separate attach and render modules.

    `$z.Component` is fully compatible with mixed render components. We can write our button as:

    button15.js (client-only version):
    ```javascript
      define(['zest', 'jquery', 'css!./button'], function($z, $) {
        return $z.create([$z.Component], {
          className: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          pipe: true,
          _events: ['click'],
          construct: function(el, o) {
            this.$button = $(el);
            this.$button.click(this.click);
          },
          prototype: {
            click: function() {
              alert('a prototype event function');
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```
    ```jslive
      $z.render('@app/button15', {
        text: 'Ok'
      }, document.querySelector('.container-31'));
    ```
    <div class='container-31' style='margin: 20px'></div>

    `$z.Component` automatically fills in the `attach` function in this case. The above is also fully-compatible with extension as expected.

    #### Next Steps

    The way we've written the button and dialog with separate render and attachment modules allows us to seamlessly render them on the server as
    well, with full build support.

    Read about this in the next section, or if building a client-only rendering app, jump to the [build section](#Building).

    ***

        """
      ]
    ,
      chapterName: 'Zest Server'
      sections: [
        sectionName: 'Server Rendering Overview'
        markdown: """

    > If you only need to use browser rendering, skip this section and [read about the production build](#Building).

    As demonstrated in the Quick Start, Zest Server can be run from the single global command, `zest`. When run, this seeks out the server configuration file, `zest.json` or `zest.cson` (the CoffeeScript equivalent) in the current folder and creates the server.

    The configuration defines all aspects of the server application, with routing and server application code loaded via server modules.

    This is the easiest way to start using Zest server rendering. Zest encourages the use of service APIs to provide data services, with Zest itself providing a rendering service.

    There are a couple of other ways to utilize the Zest render service:

    ### Using Zest Server within a NodeJS Application

    Zest Server can also be used for rendering within an existing NodeJS application. A sample NodeJS application is included in the basic server template as `~node-server.js`. 

    Within NodeJS, Zest Server can used as a request handler to provide the full routing and rendering service, or simply as a rendering function without using routing or modules.

    [Zest Server NodeJS API Reference](#NodeJS%20API)

    ### Using Zest Server in other Applications

    To use the Zest Server render function in other applications, it can be provided as a service.

    _The Zest Server render service provides a mapping from a render structure moduleID with render options to its rendered HTML._

    This HTML can then be included on any page that is configured with the base Zest RequireJS settings, and the HTML will dynamically load its own CSS and scripts with the included script tags.

    This render service is provided as an HTTP service in Zest by the server module, render-service.

    When run without any modules provided, this module is loaded by default in Zest, so that Zest Server can be used as such a render server out of the box.

    A basic HTTP adapter library in another framework can then provide a Zest rendering API within the application, allowing for JavaScript rendering as a service in other environments.

    [Zest Server Render Service Module](#Render%20Service%20Module)

    ### Server Rendering Mechanics

    To read about how the mechanics of Zest server rendering works at a low level, [see the overview at the end of this documentation](#Server%20Rendering%20Mechanics).

    _The immediate sections cover the use of Zest Server as the primary site server._

        """
      ,
        sectionName: 'Server Configuration Basics'
        markdown: """

    The server is started with the command:

    ```
      zest start [environmentName]
    ```

    * This must be run from the base folder of the application, where the `zest.cson` or `zest.json` configuration file is.
    * The `start` parameter is entirely optional.
    * The environment name is typically `dev` or `production`. This allows for environment-specific configurations to be loaded. When not provided, the default environment is loaded from the configuration. Any custom environments can also be defined.

    The `zest.cson` or `zest.json` server configuration file is a loosely written JSON or CSON configuration file, providing options for:

    > The default RequireJS configuration needed for running Zest is always added. Configurations are extended sensibly, with arrays appending and objects extending.

    * **port** _(optional)_: _The port to run the server on, defaults to 8080._
    * **hostname** _(optional)_: _The hostname of the server, if not set listens on all hostnames._
    * **modules**: _The array of server modules to load. Referenced by RequireJS ModuleIDs (which by default fall back to NodeJS module requires if not found)._
    * **require**: _Base RequireJS configuration, exactly as in the [RequireJS API documentation](http://requirejs.org/docs/api.html)._
      * **require.server**: _Server-only RequireJS configuration, extending the base configuration._
      * **require.client**: _Client-only RequireJS configuration, extending the base configuration._
      * **require.build**: _Build-only RequireJS configuration, extending the base configuration._
    * **environments**: _Allows for environment-specific configuration overrides, with `'dev'` and `'production'`
      supported by default. The environment name is the key and the environment configuration override object its value on the environments object._
    * **environment**: _The default environment name string to use._

    There are a number of other configurations that can be specified, which are mentioned along with the applicable section here, such as build configuration. Any module can also define its own configuration as well.
        """
      ,
        sectionName: 'Minimal Server Configuration'
        markdown: """

    Zest Server provides default configuration as much as possible. This includes the default RequireJS configuration and page templates needed to run Zest in the browser. The file server is set to the public folder `www` and the baseUrl module folder for RequireJS to `www/lib`.

    It is assumed that there is an install of Zest client (`volo add zestjs/zest`) in the public folder, which is included by default in the server templates.

    When run with the `zest` command, the server is started in the `dev` environment by default, on port 8080.

    For a typical application, we place the public application scripts in `www/app`, and use a Zest Server module to define our page routes.

    To set this up, we need the following configuration in `zest.json`:

    ```javascript
      modules: ['$/app'],
      require: {
        paths: {
          app: '../app'
        }
      }
    ```

    The `modules` array is an array of RequireJS Module IDs to load for the server. The `$` path is a Zest Server path referencing the root application folder. So the module file is loaded from '/app.js' in the server root outside the public folder.

    The `require` object allows RequireJS configuration to specified just as in the [RequireJS API Documentation](http://requirejs.org/docs/api.html). In this case, we specify that the `app` folder should reference `www/app`.
        """
      ,
        sectionName: 'Routing'
        markdown: """

    To define a route, we add a `routes` property to the `app.js` module file.

    > Note that if you view source, you will see the HTML of our dialog, previously created as a client render, is being rendered directly as HTML on the server. Auto-generated attachment scripts carefully ensure the rendering experience is optimized and behaves identically.

    app.js:
    ```javascript
    define({
      routes: {
        '/dialog1': {
          title: 'Dialog Page',
          body: '@cs!app/dialog'
        }
      }
    });
    ```
    
    Navigate to [/dialog1](/dialog1) to see this route. This is the dialog component exactly as created in the [Dynamic CSS render component section](#Dynamic%20CSS).

    The route is a URL pattern, which maps to a partial **Page Render Component**. In the above case, we are simply setting the `body` region and `title` property of the page render component. The `render` property on the page component is set for us to the default page template, hence why this is a partial render component. We are extending the base page render component with properties for our current page.

    ### Page Component Modules

    Instead of referencing the page component directly in the route, we can also specify a module ID to load the partial page component from.
    
    ```javascript
    define({
      routes: {
        '/dialog1': '$/pages/dialog-page'
      }
    })
    ```

    With /pages/dialog-page.js:
    ```javascript
    define({
      body: '@cs!app/dialog'
    });
    ```
        """
      ,
        sectionName: 'URL patterns'
        markdown: """
    
    For dynamic content we want to use information from the URL to become data parameters for the component render.
    
    For example, to allow the width and height to be set from the URL, we can use:
    
    ```javascript
    routes: {
      '/dialog2/{width}/{height}': {
        title: 'Dialog Page',
        body: '@cs!app/dialog'
      }
    }
    ```
    
    Navigate to [/dialog2/1024/768](/dialog2/1024/768) or try some variations of the URL as well to see this.

    Page components are rendered with options, just like any other render. The options used are created from the route itself. Since the region of a render component is rendered with the same options as the render component, the `body` render structure is passed these page options when rendering.
    
    URL patterns allow us to automatically map parts of the URL to these route render options that we provide. In the above example, whenever the URL has three arguments, with the first set to `dialog2`, the route is triggered with the initial options are set as:
    
    ```javascript
    {
      width: [second URL argument],
      height: [third URL argument]
    }
    ```
    
    This is why we took so much care with escaping the CSS in our dialog component properly. There are no URL variations that can result in injection attacks here so we are safe. But be very careful when piping options directly from the URL into the component, as this is a very real risk.
    
    ### Soaking up arguments
    
    Using **{argumentName*}** will soak up the current URL argument as well as all successive arguments.
    It must be the last provided argument. For example:
    
    ```
      /my/{property*}
    ```
    
    will map the URL `/my/full/url/string` to the options:
    
    ```javascript
    {
      property: 'full/url/string'
    }
    ```
    
    ### Query Strings
    
    When a query string is provided, it is populated on the options properties **_queryString** and as a parsed object at **_query**.
    
    For example, the URL `/my/full/url/string?some=test&object=stuff&some=arraystoo`, will trigger the route:

    ```
      /my/{property*}
    ```
    
    and will populate the options as:
    
    ```javascript
    {
      property: 'full/url/string',
      _queryString: 'some=test&object=stuff&some=arraystoo',
      _query: {
        some: ['test', 'arraystoo'],
        object: 'stuff'
      }
    }
    ```

    ### 404 Pages

    When no route is matched, and no pageComponent is set for rendering, the request is passed to the file server. If the request isn't a valid file in the `www` folder, then the 404 Not Found page is shown. By default this is the 404 page from the [HTML5 Boilerplate](http://html5boilerplate.com/), but it can be customized to any partial page component just like any route.

    To set the 404 not found page, add the `404` property in the main Zest configuration file:

    ```javascript
    {
      404: {
        title: 'Page Not Found',
        body: '&lt;p>No page here&lt/p>'
      }
    }
    ```
    
        """
      ,
        sectionName: 'Dynamically Setting Render Options'
        markdown: """
    There is only so much that can be done with direct options mapping. Typically we need the page component to also do its own loading and populate the data accordingly.

    For this, we can use the `load` and `options` render component properties, just like any other render component:

    ```javascript
      routes: {
        '/dialog3': {
          title: 'Dialog Page',
          body: '@cs!app/dialog6',
          options: {
            width: 400,
            height: 300,
            confirmText: 'Ok'
          },
          load: function(o) {
            o.content = '&lt;p>The time is ' + (new Date()).toLocaleTimeString() + '&lt;/p>'
          }
        }
      }
    ```

    Try this out here: [/dialog3](/dialog3).

        """
      ,
        sectionName: 'Page Component Reference'
        markdown: """

    The full list of properties on the page render component are:

    * **title**, String: _Sets the title of the page._
    * **head**, Render Structure: _Sets any extra rendering in the head region of the page._
    * **body**, Render Structure: _Sets the body region of the page._
    * **footer**, Render Structure: _Sets the footer region of the page, after the body. Useful for analytics scripts._
    * **lang**, String: _Sets the HTML `lang` attribute for the page language._
    * **scripts**, Array: _Any **blocking** scripts to load into the page. URLs are relative to the RequireJS baseUrl. Not recommended to use unless absolutely necessary. Typically scripts are built and [@loaded as layers](), not blocking the page unnecessarily._
    * **requireMain**, String: _Sets the RequireJS `data-main` entry point for the page._
    * **requireConfig**, Object: By setting properties here, page-specific RequireJS configuration can be provided, extending the defaults set by Zest.

    All of these properties support intelligent extension (the page component is generated by an internal `zoe.create` call).

    ### Overriding the Page Template

    The page template is roughly based on the [HTML5 boilerplate](http://html5boilerplate.com/), and in most cases the properties above provide all necessary customization. If you still really need to alter the HTML template for the page render component, then set the `render` property on the page component. Read the page component definition at `node_modules/zest-server/html.coffee` as a reference for this.    

        """
      ,
        sectionName: 'Base Page Template'
        markdown: """

    Modules form a collection of routes that may share similar RequireJS configuration and other properties.

    To avoid repetition, we can specify a **Base Page Component** that can provide base page component properties, 
    before being extended by a specific page component for a route.

    This can be set on both modules and in the main `zest.json` configuration file.

    It is set as the `page` property on the module, and will apply whenever a route from the module is matched.

    In the configuration file, it can also be set to be environment-specific (like all other configuration options).

    For example, a module-specific `map` config could be provided with:

    ```javascript
      page: {
        requireConfig: {
          map: {
            '*': {
              'my/module': 'something'
            }
          }
        }
      }
    ```

    set as a property on the module, and similarly for other properties and configurations.

        """
      ,
        sectionName: 'Browser Modules'
        markdown: """

    If attempting to render a mixed render component on the server, that loads dependencies only usable in the browser (such as jQuery), this will give an error.

    To make rendering of these components possible, there is a configuration for **Browser Modules**, which are automatically loaded as empty dependencies.

    To inform Zest Server that jQuery is a browser module, we add the `browserModules` configuration array in the configuration file:

    zest.json:
    ```javascript
    {
      browserModules: ['jquery']
    }
    ```

    This can be a list of any number of RequireJS module IDs.

    This isn't necessary on components with separate attachment modules.

        """
      ,
        sectionName: 'Quick Refresh'
        markdown: """

    > To install Nodemon, use npm:  
      `npm install nodemon -g`

    When developing, [nodemon](https://github.com/remy/nodemon) is great for automatically refreshing the server allowing quick reloading.

    The Zest Server command supports Nodemon by starting the server with the argument:

    ```
      zest start-nodemon [environmentName]
    ```

    The `environmentName` is optional.

    All file changes will then restart the server.

        """
      ,
        sectionName: 'Asynchronous Streaming'
        markdown: """

    To demonstrate the asynchronous streaming used by Zest Server, let's mimic a heavy loading function in the content of the dialog, taking 3 seconds to load data:

    ```javascript
      routes: {
        '/dialog4': {
          title: 'Dialog Page',
          body: '@cs!app/dialog6',
          options: {
            width: 400,
            height: 300,
            confirmText: 'Ok'
            content: {
              load: function(o, done) {
                setTimeout(done, 3000);
              },
              render: function(o) {
                return '&lt;p>Heavy data load complete&lt;/p>';
              }
            }
          }
        }
      }
    ```

    [See this running here](/dialog4). Wait 3 seconds to see the content display. To see what is going on, try viewing the source and refreshing the source code view.

    The content region of the dialog is set through the options (a public region), allowing us to set it to any render structure we like. In this case we set it to a render component and use the asynchronous load of the render component.

    When rendering, Zest Server will render as much as it can, until it reaches a loading render component. It will then pause the stream while the load completes.

    During loading, the styles of partially loaded components will always be fully active, and the interactions of components with all their HTML rendered will already be attached.

    The attachment for the dialog is only run on completion of the loading of all HTML of the dialog. If the button was rendered before the content region, it would display during this loading time and have its own attachment already run so that it would be interactive, but the dialog would not have attached to the button yet so that clicking the button while the dialog HTML is still rendering would have no effect until the dialog had fully loaded, at which point the button would properly close the dialog again.

    ### Testing Slow Page Loads

    It can be useful to test partial page loads at this level quite thoroughly in order to optimize the page loading experience.

    There are two configuration options that can be used to provide artificial load delays:

    * **renderDelay**: _A time interval in milliseconds to delay any render component rendering._
    * **staticLatency**: _A time interval in milliseconds to delay any file server download._

    #### Example Configuration Environment

    It can be useful to define a `dev-delay` environment with these options enabled.

    We can include the environment override in the Zest Server configuration with:

    zest.json:
    ```javascript
    {
      environments: {
        'dev-delay': {
          staticLatency: 500,
          renderDelay: 500
        }
      }
    }
    ```

    Then we can start the environment with:

    ```
      zest start dev-delay
    ```
        """
      ,
        sectionName: 'Build Environment'
        markdown: """

    Once development is complete, we build all of the separate files into a single script (or layered scripts) to be included in the page.

    This is done by specifying build configurations, and then running the server in a build environment.

    Build environments are any environments, which specify the main configuration option:

    ```javascript
    {
      build: true
    }
    ```

    When started, the site will run a whole project build with the RequireJS Optimizer and then switch to the built public folder to serve the site, from minified layers. Details of the build settings are provided in the [build section](#Building).

    There is a default build environment included, which provides all of the fastest build settings in the RequireJS optimizer.

    This is called `dev-build`.

    When experimenting with build configurations, run in this environment:

    ```
      zest start dev-build
    ```

        """
      ,
        sectionName: 'Production Environment'
        markdown: """

    Once ready to go into production, the site can be started in the production environment by passing the `production` environment name into Zest Server:

    ```
      zest start production
    ```

    The production environment is a default environment specified in the default server configuration as:
    ```
    environments: {
      production: {
        build: true,
        production: true
      }
    }
    ```

    This environment will perform full minification of all files, and so make take a while to run. The RequireJS optimizer settings can still be tweaked using overrides as necessary.

    ### File Server Cache Expiry

    A useful configuration for production is the file server cache expires header.

    This can be set with the `fileExpires` configuration option, which takes a value in milliseconds.

    An alternative file server can also be set up separately to Zest Server, and the file server disabled with `serveFiles: false`.

        """
      ,
        sectionName: 'Module Request Handlers'
        markdown: """

    Modules can provide NodeJS-style request handlers, allowing direct access to the `request` and `response` NodeJS objects.

    The handler module properties are:

    * **handler, function(req, res, next)**: _Runs only when one of this module's routes has been matched by the current request. Suitable for data loading, module-specific middleware and minor page component adjustments._
    * **globalHandler, function(req, res, next)**: _Runs on all application requests, regardless of what route may or may not have been matched. Suitable for service API requests and global middleware._

    These handler properties are set directly on the module object, just like the `routes` property. They are just standard NodeJS request handlers.

    The handlers are run after routing but before rendering, allowing the handler the ability to entirely intercept the page output (by never calling `next` and sending a response), or to modify the page render component or page options before rendering.

    The page is rendered from the following request properties, which are the only request properties created or read by Zest Server:

    * **`req.pageComponent`**: _The partial page component to render, before the base page component extensions have been applied. If not present, a 404 not found page is provided._
    * **`req.pageOptions`**: _The page component render options, as provided from the routing output._
        """
      ,
        sectionName: 'Adding Middleware'
        markdown: """

    With full access to the request and response objects, the modules can thus add middleware to the application if necessary.

    If using connect, add this as a module dependency. As long as there is no RequireJS module called 'connect', RequireJS will fall back to loading this as a NodeJS dependency.

    For example, to load Connect middleware and session management (after installing connect - `npm install connect`)
    within a module, one can do:

    > Note this Connect support is currently only working in the master branch of Connect, pending the release of Connect version 2.7.3.

    ```javascript
      define(['zest', 'connect'], function($z, connect) {
        return {
          routes: {
            '/some/route': 'my/module'
          },
          handler: $z.fn('ASYNC')
            .on(
              connect()
                .use(connect.cookieParser())
                .use(connect.session, {key: 'sid', secret: 'secret', store: (new connect.session.MemoryStore())})
            )
            .on(function(req, res, next) {
              // copy the session data into the page render options
              req.pageOptions.session = req.session;
            });
          );
        };
      });
    ```

    The ZOE async function chain allows for easy creation of server handler functions - [read its documentation here](http://zoejs.org/#zoe.fn.ASYNC).
    ***
        """
      ,
        sectionName: 'NodeJS API'
        markdown: """

    > If you are not needing to integrate Zest Server within your own existing framework, [skip to the build section](#Building).

    To use Zest Server within NodeJS instead of through the `zest` command, there is an example in the basic server template. First ensure that Connect is installed, then start the NodeJS application with:
    
    ```
      node ~node-server.js
    ```

    The server loads Zest as a dependency with the following code:

    ```javascript
      var connect = require('connect');
      var zest = require('zest-server');

      var app = connect();

      zest.init('dev', function() {
        app.use(zest.server);
        app.listen(8080);
      });
    ```

    * **zest.init(environment, callback)**: _Loads the server configuration file from `zest.json` or `zest.cson` in the application folder with the environment string specified. The callback function is called when loading is complete._
    * **zest.server**: _The NodeJS request handler of the form `function(req, res, next)` that performs all Zest Server operations. It runs routing, hooks the Zest Server modules, renders the output into the response and provides file serving._

    #### Disabling the 404 Page

    To have the Zest Server route handler call the `next` callback when used within NodeJS, the 404 Not Found page must be disabled. Simply set `404: null` in the Zest Server configuration file to disable the 404 catch-all, then additional handlers can be used after `zest.server`.

    To disable the file server, [see the next section](#File%20Server%20and%20Paths%20Configurations).

    ### Rendering APIs

    Instead of using `zest.server` as the handler, it is also possible to use the Zest Server rendering function directly, skipping the module and routing support entirely.

    It is still necessary to run the `zest.init` method to load the configuration before using any of these API methods.

    #### zest.render

    ```javascript
      zest.render(structure, [options], res, [complete])
    ```

    * **structure**: _The render structure to render. Any render structure may be provided._
    * **options**, optional: _The render options to provide. If not provided, an empty options object is used._
    * **res**: _The NodeJS response object to write to. Zest Server will write the headers, stream the response and close the connection on completion._
    * **complete**: _An optional complete callback._

    `zest.render` expects to write the headers and close the response stream, and so can't be used for partial output within a template.

    > If you are interested in partial rendering within a page template, please [post an issue to Zest Server](https://github.com/zestjs/zest-server). It is trivial to provide, but harder to justify, so it would be appreciated to hear about any use cases.

    Thus, `zest.render` should typically be used with a full page component, that renders the HTML template as we do with standard routing.

    #### zest.renderPage

    **This is the most suitable render function for use within a NodeJS application.**

    ```javascript
      zest.renderPage(pageComponent, [options], res, [complete])
    ```

    The options are all identical to the above `zest.render`, except that by default it is assumed that the render structure is a partial page render component.

    The partial page component is extended to provide the page template `render` function as well as the standard RequireJS configuration. In this way the partial page component is extended identically to the standard route rendering system.

    Example:

    ```javascript
      zest.renderPage({
        title: 'My Page'
        body: '@body/component/id'
      }, pageDataOptions, res);
    ```

    #### zest.require

    Zest also provides direct access to the correctly configured RequireJS `require` function at `zest.require`, which can be used to load modules from the `www/lib` folder or other paths with all the correct RequireJS configuration.
        """
      ,
        sectionName: 'File Server and Paths Configurations'
        markdown: """

    When using Zest Server from within NodeJS or another framework you may wish to change the folder paths around.

    The following configuration options are provided for this:

    * **publicDir**: _The public folder. Defaults to 'www'._
    * **publicBuildDir**: _The public built folder. Defaults to 'www-built'._
    * **baseDir**: _The base js folder relative to the public folder. Defaults to 'lib'._
    * **serveFiles, boolean**: _If set to false, the Zest Server file serving is disabled assuming there is another file server providing the `publicDir` file requests. Defaults to true._ 

        """
      ,
        sectionName: 'Render Service Module'
        markdown: """

    There is a **Render Service Module** provided with Zest Server, that simply acts as an HTTP rendering service. Think of it like a local database or search server. This service should only be enabled on a private server as it provides access to the file system. The moduleIDs that get requested should always be from a set list of secure modules.

    To enable the render service module, it would be enabled with the following configuration:

    zest.json
    ```javascript
    {
      modules: ['$render-module']
    }
    ```

    But if the `modules` array in `zest.json` is empty, this module is loaded as a fallback module, allowing Zest Server to be a provide the render service by default.

    Once enabled, it responds to the service requests:

    <code>**POST** /render:{moduleId*}</code>

    <code>**POST** /renderPage:{moduleId*}</code>

    * **render / renderPage**: _The render mode to use (render a normal component or partial page component)._
    * **moduleId**: _The render structure module ID to render._
    * **POST body**: _The strictly encoded JSON render options._
    * **POST response**: _The rendered HTML, as an efficiently streamed output._

    If the module ID is not found, or there is an error loading, a 500 header will be returned, with the body containing the error message.

    For example, for the following POST request:

    ```
      curl -d '{"width":50}' 'http://localhost:8081/render:app/Dialog/dialog'
    ```

    the response is:

    ```
      <style data-zid="z1">
      #z1{ 
        width: 50px;
        height: 300px;
      }
      </style>
      <script src='/lib/require-inline.js' data-require='css!app/Dialog/button,css!app/Dialog/dialog'></script> 
      <div id="z1" component class="SimpleDialog">
        <div class="button">
          <button id="z2" component class="MyButton">Button</button>
          <script src='/lib/require-inline.js' data-require='zest,app/Dialog/button-attach'></script> 
          <script src='/lib/zest/attach.js' data-zid='z2' data-controllerid='app/Dialog/button-attach'></script> 
        </div>
      </div>
      <script src='/lib/require-inline.js' data-require='zest,app/Dialog/dialog-attach'></script> 
      <script src='/lib/zest/attach.js' data-zid='z1' data-controllerid='app/Dialog/dialog-attach'></script>
    ```

    > If you use this service to create a render library for any other frameworks, [create an issue](https://github.com/zestjs/zestjs.org) to post the link here.

    The attachment scripts are all designed to work so long as the rendering page `lib` folder is found as expected, and the module IDs match up to what is expected. This includes instant CSS injection without flashing and script loading with instant enhancements. 

    In production, the only difference in the HTML is that the `require-inline.js` and `attach.js` requests will be mapped to the single built file name. This is automatically changed when running Zest Server in the production environment. With paths mappings, the RequireJS module IDs get mapped to their correct built layer to load from.

    The render server is started in a production environment in the same way as before.

    To examine how the above script output works, [an explanation is given here](#Server%20Rendering%20Mechanics).
        """
      ]
    ,
      chapterName: 'Building'
      sections: [
        sectionName: 'Running the Build'
        markdown: """

    As mentioned in the Quick Start, running the build in the Zest Client template involves running:

    ```
      r.js -o build.js
    ```

    and running the build in Zest Server is to simply start the server in the production environment:

    ```
      zest start production
    ```

    The build involves copying the entire public folder, `www` to a new built public folder, `www-built` containing
    the minified and built equivalents of necessary files. This is entirely handled by the RequireJS Optimizer.

        """
      ,
        sectionName: 'Configuring the Build'
        markdown: """

    In the Zest Client template, the build configuration is located in the file `build.js`.

    In Zest Server, the build configuration is located as the configuration item `require.build` in the
    `zest.cson` or `zest.json` server configuration file.

    ### RequireJS Optimization Process

    To understand the build process it is recommended to read the [RequireJS Optimizer documentation](http://requirejs.org/docs/optimization.html) for whole project builds. A very brief overview is given here.

    The primary build specifier is the `modules` array in the RequireJS build configuration. Each array item typically contains the following properties:
    
    ```javascript
    modules: [
      {
        name: 'moduleName',
        create: true,
        include: [deps],
        exclude: [deps]
      }
    ]
    ```

    * **name**: _The RequireJS module ID to be built. This module will have all its dependencies traced and included along with it in the built file, all minified nicely into the single file._
    * **create**: _When the file corresponding to the module ID doesn't already exist, this specifies that it should be created._
    * **include**: _An array of module IDs to add into this built file (in addition to any traced from the `name` module ID), also to have their dependencies traced and included._
    * **exclude**: _An array of module IDs to exclude from this build file, including all their dependencies._

    Exclude items can also be other layers in the modules list that have been created. In this way, we can have a core module containing the scripts used by most pages of the application, and then page-specific modules which contain just the extra scripts needed for pages.

    The easiest build that's suitable for most small applications is simply to build everything into a single script file.

    For multi-page applications that share varying code between pages and applications that may load modular functionality after the page load, different layers can be used to tier the loading process.
        """
      ,
        sectionName: 'Single File Build - Zest Client'
        markdown: """

    > If using Zest Server, [skip to the Zest Server Single File Build](#Single%20File%20Build%20-%20-Zest%20Server).

    In the [Zest browser template example](#Install%20Zest%20Client), we have the build file:

    build.js:
    ```javascript
      {
        appDir: 'www',
        dir: 'www-built',

        mainConfigFile: 'www/main.js',

        // faster build - only minifies layers
        skipDirOptimize: true,
        keepBuildDir: true,

        modules: [
          {
            name: '../main',
            include: ['app/main']
          }
        ]
      }
    ```

    The natural process of building in a module which requires a component is enough to ensure that the CSS and attachments are included as needed in the build.

    The plugins we've used ensure that the RequireJS Optimizer does everything for us.

    To ensure that the attachment modules are included, we need to have at least one component in a build layer require the Zest client library itself.

        """
      ,
        sectionName: 'Single File Build - Zest Server'
        markdown: """

    When running a server build, Zest Server drives the optimization process for us.

    It creates a default blocking script layer for the page, `zestLayer`.

    This layer by includes RequireJS and the core libraries necessary for Zest.

    We can add to it by ammending it on the RequireJS build configuration, even though it isn't strictly a RequireJS configuration.

    _When building render components which are only rendered on the server, we don't want to include the render component itself in the build
     as this code won't be needed on the client._

    _For this purpose, we use an **Attachment Build**, which is indicated by the sudo-plugin syntax `^!renderModuleID`._

    _This builds in just the CSS or compiled LESS, along with the full dependency trees of the attachment module scripts for the components._

    To build just the attachment scripts necessary to display the dialog, we use the build configuration:

    In zest.json or a module:
    ```javascript
      require: {
        build: {
          zestLayer: {
            include: ['^!cs!app/dialog']
            //'exclude' and 'excludeShallow' can also be provided here
          }
        }
      }
    ```

    **The above is the only necessary configuration to ensure all dependencies for server rendering of the dialog are included on the page.**

    We can still build in a component normally to include the render component scripts as well where client rendering is needed.

    Running `zest start dev-build` or `zest start production` will then enable loading all scripts from this layer.

    For small sites such as this one, this build is sufficient - all resources are loaded from a single file.

    For larger sites, some thought should be taken to structure multiple layers between pages.

        """
      ,
        sectionName: 'Separate CSS Build - Zest Server'
        markdown: """

    The single `zestLayer` script will dynamically inject the page CSS, minimizing the page load to a single script request.

    To support environments that don't execute JavaScript, a `separateCSS` option can be set to build the layer CSS into
    a standard `<link>` tag instead.

    To enable this, set the `separateCSS` property on the `zestLayer` object in the build:

    ```javascript
      require: {
        build: {
          zestLayer: {
            include: ['^!cs!app/dialog'],
            separateCSS: true
          }
        }
      }
    ```

    All build modules support separateCSS as it is a feature of the [Require-CSS module](https://github.com/guybedford/require-css).

    For other build layers, this separate CSS will need to be included manually as needed in the page component `head` region.

        """
      ,
        sectionName: 'Multiple Layer Build - Zest Server'
        markdown: """

    #### Building Multiple Layers

    To build additional layers alongside the `zestLayer`, we use the standard `modules` build option:

    In zest.json or a module:
    ```javascript
      require: {
        build: {
          zestLayer: {...},
          zestExcludes: {...},
          modules: [
          {
            name: 'product-page',
            include: ['^!pages/products'],
            exclude: ['zest/layer', 'zest/excludes']
          }
          ]
        }
      }
    ```

    The excludes, `zest/layer` and `zest/exclude` provide standard excludes for layers to ensure they don't include unnecessary core scripts.

    The exclude layer can also be ammended by using the `zestExcludes` configuration just like `zestLayer`.

    #### Configuring Mulitple Layer Loading

    Zest Server automatically includes the layer map for the `zestLayer` built layer in each loaded page. This ensures that a request to a module located within the
    `zestLayer` will seek the layer first and not attempt to download the module separately.

    When running multiple layers on a page, typically all other layers should not be loaded at all but only requested asynchronously when they are needed
    (although they could be added as blocking page scripts in the page configuration if really desired).

    By including a layer map in the page, any module request can trigger a layer load from the suitable layer as needed, without it needing to be loaded or executed first.

    By default, only the layer map for the `zestLayer` is included in all pages. When using multiple layers in the page, Zest Server will
    include the layer maps of layers contained in the `layers` property on the page component.

    So we add our layer name to the page either in the base site configuration, module configuration, or specific page route configuration.

    For example in module:
    ```javascript
      routes: {
        '/product/page': {
          title: 'Page Title',
          body: '@pages/products',
          layers: ['product-page']
        }
      }
    ```

    The above allows full build flexibility for optimizing the page loads at a low level.

        """
      ]
    ,
      chapterName: 'Appendix'
      sections: [
        sectionName: 'Server Rendering Mechanics'
        markdown: """

    For those interested in understanding what Zest Server is doing at a script level, an explanation of the process
    is given here.

    _The main principle of the Zest Server output is that a single HTML string should be able to completely describe the rendering
     and attachment of a component, including its styles and controller such that it can be streamed straight to the browser._

    Accomplishing the above while maintaining full compatibility with RequireJS, which is naturally asynchronous, is key to this approach.

    Here is the example output for a button component rendered on the server:

    ```
      <script src='/lib/require-inline.js' data-require='css!app/button'></script>

      <button id="z1" component>Button</button>

      <script src='/lib/require-inline.js' data-require='zest,cs!app/button'></script> 

      <script src='/lib/zest/attach.js' data-zid='z1' data-controllerid='cs!app/button-controller' data-options='{pipedOptionsJSON}'></script>
    ```

    The inline requires are performed using the [require-inline](https://github.com/guybedford/require-inline) RequireJS addon,
    which provides a full-compatible synchronous inline script loading capability.

    The load process then takes the following form as above:

    1. The `<script>` tag before the button HTML ensures that the button style has been loaded, blocking the page while it does this.
       If the CSS is built into a layer, it will load that layer. If the CSS has already been loaded, this will be instantaneous.

    2. The HTML for the button is then displayed, now that the styles have been loaded so that styled HTML is displayed.

    3. Any regions within the component have the same cycle applied to themselves.

    4. The attachment module for the button is loaded. When the `progressive` property on the component has been enabled,
       the attachment will not block the page and the third line of script above is ommited by the render function causing
       progressive enhancement behavior.
       For critical attachments, the page will not display further until the attachment script is loaded.
    
    5. Finally the attachment script is executed and the controller registered to the element. The options for attachment
       are loaded from the `data-options` JSON attribute, as provided by the render component pipe function on the server.

    The idea is that these critical requires form a **critical path** for the page load at a fine level. In production,
    this critical path should be minimized as far as possible to be a small single blocking layer ideally, with asynchronous parallel layers 
    downloaded after this blocking page path.

    In terms of future technology support, when SPDY becomes mainstream, builds may become redundant, allowing for such requires to work in production
    without layering being necessary. The use of script tags without inline script also ensures that this approach can be compatible with
    a Content Security Policy.

    When components have been designed for progressive enhancement, the attachment scripts can be non-blocking, but extra care needs
    to be taken when dealing with component communication using asynchronous component selection and controller behavior.

    Components that have a highly dynamic behaviour can use render and require calls within their attachment code to dynamically
    render more complex interactions. This way the component can display quickly with some partial scripts before fully rendering into itself with
    more complex interaction and data. 

    This can form a more advanced version of progressive enhancement, with baseline script behaviour loaded within the critical layer,
    followed by more complex scripts loaded dynamically. These dynamic scripts can then be built into separate async layers, 
    so that the core critical layer remains minimal.

        """
      ]
    ]
