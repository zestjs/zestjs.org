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
      in this example are numbered as we have some evolving to do).
    
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
    defining the render component with its `render` property as we wrote previously.
    
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
    This allows for writing template in-line and keeping Render Components nicely readable.
    
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
    
    Since the jade plugin supports builds, the above would also support adding the compiled template into the build, without including
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
          type: 'MyButton',
          render: function(o) {
            return '&lt;button>' + o.text + '&lt;/button>';
          }
        }
      });
    ```
    
    The use of `./` in the dependency name is the RequireJS syntax for a relative path so our code remains completely portable. It loads
    `button.css` from the same folder as `button.js`.
    
    We need a unique class on the component to ensure our CSS is properly scoped. We can either add a class name into the template HTML,
    or we can give the component a **Component Type** name, which is specified with the `type` property above. The `type` property must always start with a capital letter.
    
    > If you'd rather write valid XHTML, you can configure
      Zest to use the attribute `data-component` instead. To enable this, add the configuration option `typeAttribute: 'data-component'`
      to the Zest Server configuration file, or under the `zest/zest-render` RequireJS configuration in the browser template.
    
    When rendering, the `type` name is automatically added as the `component` attibute on the element, so the HTML will render as the element:
    
    ```
      <button component='MyButton'>
    ```
    
    The `component` attribute makes it easier to see Render Components when inspecting the DOM.

    Many components with the same `type` name can be rendered on the same page, allowing CSS inheritance. It is worth ensuring this name is chosen carefully not to be shared unintentionally though.

    We can then use the attribute selector in our CSS as the main scope. Attribute-equals selectors are supported in IE7+ and on mobile devices.
    If you need IE6 support, rather add a class to the template HTML and style the class instead.

    > Styling by class or component type is highly recommended. If you know for certain the component will only be rendered once in the page, and really want to use an ID, this will work fine.

    We create `button.css` in the same folder:
    ```css
      button[component="MyButton"] {
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
          type: 'MyButton',
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
    * **$z.esc(val, 'num', [NaNVal])**: _Parses the value as a number, providing the NaNVal if not a number._
    * **$z.esc(val, 'cssAttr')**: _Ensures the value is a single CSS attribute, escaping `:`, `{`, `}` and `"`. Single quotes are not escaped,
      so that using this in a single-quoted HTML style attribute will not be safe. It can only be safely used within a double quoted HTML style attribute tag, such as demonstrated in the [dynamic CSS]() section._

        """
      ,
        sectionName: 'Dynamic Attachment'
        markdown: """

    Render components can be both static and dynamic. For any form of interaction, we can provide an `attach` method
    which creates a dynamic render component.

    button5.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(el, o) {
            el.addEventListener('click', function() {
              alert('click');
            });
          }
        };
      });
    ```

    > Note that dynamic render components should always have a single wrapper HTML tag, so that they can be properly
      attached.
    
    ```jslive
      $z.render('@app/button5', {
        text: 'Click Me!'
      }, document.querySelector('.container-9'));
    ```
    <div class='container-9' style='margin: 20px'></div>
    
    The first argument of the `attach` function, `el`, is the main wrapper DOM element from the template. 
    Hence `el` is the `<button>` DOM element.
        """
      ,
        sectionName: 'Separate Attachment'
        markdown: """

    The attach property can also be a Module ID string to reference a separate module to load the attachment function from.  This allows for the attachment code to be built separately to the render code when components are only going to be rendered on the server. Note that the CSS is always a dependency of the render code.

    To do this, we would write the button attachment module in `button-controller.js` as:
    ```javascript
      define([], function() {
        return function(els, o) {
          els[0].addEventListener('click', function() {
            alert('click');
          });
        }
      });
    ```

    And then update the `attach` property in the button render component to be:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: './button-controller'
        };
      });
    ```
    to reference the module as a relative module ID.
    
    It is advisable to use a separate attach module for server render components (layouts / menus etc), but an inline attach module
    is nicer to work with during prototyping and can be used for components only ever rendered in the browser such as popups or in single-page applications.
    
        """
      ,
        sectionName: 'Piping Attachment Options'
        markdown: """
  
    The second argument sent to the attach function is the **Attachment Options** object. By default, the attachment options provided to the attachment function is an empty object. We need to manually
    populate the attachment options from the render options by providing a **Pipe Function**.

    As an example, let's provide an option to customize a message when the button is clicked.
    
    button6.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'MyButton',
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
          attach: function(els, o) {
            els[0].addEventListener('click', function() {
              alert(o.message);
            });
          }
        };
      });
    ```
    
    Pipe is a function, taking the render options object and outputting the options object to use for
    attachment. These options are then sent to the `attach` function.
    
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

    When writing components for client rendering only, setting `pipe: true` will pipe all options by default.

    #### Next Steps

    Will will come back to this button example shortly to demonstrate [@controller registration](#controller). But first we will cover creating hierarchies of components using **Regions**.

        """
      ,
        sectionName: 'Regions'
        markdown: """
    Any template can define a named region using the syntax <code>&#96;{RegionName}&#96;</code>. 

    For example, we can create a dialog render component, permitting any content:

    dialog1.js:
    ```javascript
      define(['css!./dialog'], function() {
        return {
          type: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;/div>"
        };
      });
    ```
    
    dialog.css:
    ```css
      div[component="SimpleDialog"] {
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
      define(['app/button6', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;div class='button'>{&#96;button&#96;}&lt;/div>&lt;/div>",
          button: Button
        };
      });
    ```
    By importing the Button component directly, (instead of setting the region to `'@app/button6'`), when we build the dialog into a single file, this will then automatically include the button styles and scripts along with it.
    
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
        sectionName: 'Render Structures'
        markdown: """

    As mentioned in the first section, there are 5 **Render Structures** that can be rendered by `zest.render` or through regions on both the client and server. All render structures accept a render options object. When no options are provided, an empty options object is used. 

    The render structures are:

    * **Module ID, String**: _A string prefixed with `@` indicating a RequireJS Module ID to load the render structure from._
    * **HTML, String**: _A string of HTML to render, supporting regions with the syntax <code>&#96;{RegionName}&#96;</code> from the render options._
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
      define(['app/button6', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
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
      }, document.querySelector('.container-13'));
    ```
    <div class='container-13' style='margin: 20px'></div>

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
      }, document.querySelector('.container-14'));
    ```
    <div class='container-14' style='margin: 20px'></div>

    The above **Instance Render** allows us to specify a structure to render and with what options.

    The instance render is actually just a render component variation. In both of the above cases, it is rendered with an empty options object, which then has its default options set from the `options` property (like any other render component) so that the options become a clone of the default options. This cloned options object is then passed to the child render call for the button.

    For regions with multiple items, we can return an array of instance renders from the render function on the region,
    each with their own mapped options.

    ***
          """
      ,
        sectionName: 'Attaching Controllers'
        markdown: """

    To be able to communicate with the button component we need a controller object that we can talk to.

    The controller forms a public interface, allowing for the button to provide methods, properties and events.

    The controller is just a JavaScript object, and the interface is whatever is put on that object.
    
    **The return value of the `attach` function is the controller for that render component.**
    
    Let's add a controller to our button with a click event hook. The previous popup message and pipe
    function have been removed.

    button7.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(el, o) {
            var clickEvent = $z.fn();
            el.addEventListener('click', clickEvent);
            
            return {
              click: clickEvent
            };
          }
        };
      });
    ```

    The button controller returned from the attach function provides a single property, `click`, which can be used to attach click event handlers to the button by simply writing:

    ```javascript
      buttonController.click.on(function() {
        // custom click event handler
      });
    ```

    This event is generated from the `$z.fn()` function provided by `zoe.js`, which is a small optional library included with Zest for object extension, inheritance and this simple event model. It is covered in more detail in the next chapter, $z.Component.

        """
      ,
        sectionName: 'Component Selection'
        markdown: """

    Zest registers all dynamic components under their unique ID (matching the HTML ID), along with their (non-unique) component type name.

    The standard way of getting access to the component controller is by using the Zest **Component Selector**.
    
    The component ID can be selected just like a HTML ID, and the component type name can be selected just like a tag name in HTML.
      
    The selector functions are:

    ```javascript
      $z.select(selectorString, context);
    ```
    and
    ```javascript
      $z.selectAll(selectorString, context);
    ```

    As a shortcut to `$z.selectAll`, `$z` is an alias to this selector function just like jQuery.
    
    `select` is the analogue of `document.querySelector`, and `selectAll` is the analogue of `document.querySelectorAll`.

    The component selector gets converted into a normal DOM selector, with its output returning the component controller instead of its elements.

    The context is an optional container DOM element within which to do the selection.
    
    Examples:
      
    > Zest will automatically polyfill the browser selection engine by downloading Sizzle from cdn if the browser doesn't support attribute-equals selectors. This is provided by the [selector](https://github.com/guybedford/selector) RequireJS module.

    ```javascript
      // returns array of all 'MyButton' components
      // query selector: '*[component="MyButton"]'
      $z('MyButton');
      
      // returns array of all 'MyButton' components inside any 'SimpleDialog' component
      // query selector: '*[component="SimpleDialog"] *[component="MyButton"]'
      $z('SimpleDialog MyButton');
      
      // returns array of all 'MyButton' components inside the container 'myDiv'
      // that are the direct child of a form element
      // query selector: 'form > *[component="MyButton"]'
      $z('form > MyButton', myDiv); 
    ```

    The component in the selector must always be referred to with its capitalized type name. The distinction is made that HTML tags are lowercase, while components start with an uppercase. The final item in the selector will be restricted to a component only. All other standard CSS selector syntax can be used.
    
    Let's create a button with a given ID and then use the component selector to get its controller:
    
    ```jslive
      $z.render('@app/button7', {
        id: 'button7',
        text: 'Button 7'
      }, document.querySelector('.container-15'), function() {
      
        $z.select('#button7').click.on(function() {
          alert('hooked click!');
        });
        
      });
    ```
    <div class='container-15' style='margin: 20px'></div>
    
    Note that because rendering is asynchronous, we've put the interaction code in the complete callback for the render function to ensure that rendering is completed before we run the component selector.
        
        """
      ,
        sectionName: 'Disposal'
        markdown: """
        
    The controller can have any properties at all. The only method that Zest makes assumptions about is the **dispose** method.
    If it exists, this method is called when the element is disposed.
    
    We can add a dispose method to the button controller to correctly detach our events to prevent memory leaks.

    button8.js:
    ```javascript
      define(['zest', 'css!./button'], function($z) {
        return {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(el, o) {
            var clickEvent = $z.fn();
            el.addEventListener('click', clickEvent);
            
            return {
              click: clickEvent,
              dispose: function() {
                el.removeEventListener('click', clickEvent);
              }
            };
          }
        };
      });
    ```
    
    The `dispose` method on the controller is updated so that we can call it to run the entire disposal:
    
    ```jslive
      $z.render('@app/button8', {
        id: 'button8a',
        text: 'Dispose Me'
      }, document.querySelector('.container-16'), function() {
      
        var button8a = $z.select('#button8a');
        button8a.click.on(function() {
          button8a.dispose();
        })
        
      });
    ```
    <div class='container-16' style='margin: 20px'></div>
    
    There is also a global dispose method, `$z.dispose` which can be called on any DOM element or element collection to find and dispose all components within that HTML, including running their disposal hooks:
    ```jslive
      $z.render('@app/button8', {
        id: 'button8b',
        text: 'Dispose Me'
      }, document.querySelector('.container-17'), function() {
      
        $z.select('#button8b').click.on(function() {
          $z.dispose(document.querySelector('.container-17').childNodes);
        });
        
      });
    ```
    
    <div class='container-17' style='margin: 20px'></div>
        """
      ,
        sectionName: 'Controller Communication'
        markdown: """

    We can now hook the button click method from the dialog component.

    Let's set it up to close the dialog when the button is clicked:
    
    dialog4.js:
    ```javascript
      define(['app/button8', 'css!./dialog'], function(Button) {
        return {
          type: 'SimpleDialog',
          render: "&lt;div>{&#96;content&#96;}&lt;div class='button'>{&#96;button&#96;}&lt;/div>&lt;/div>",
          button: function(o) {
            return {
              render: Button,
              options: {
                text: o.confirmText,
              }
            };
          }
          attach: function(el, o) {
            var MyButton = $z.select('> .button MyButton', el);
            MyButton.click.on(function() {
              $z.dispose(el);
            });
          }
        };
      });
    ```
    
    And see it in action:
    ```jslive
      $z.render('@app/dialog4', {
        content: '&lt;p>content&lt;/p>',
        confirmText: 'Ok'
      }, document.querySelector('.container-18'));
    ```
    <div class='container-18' style='margin: 20px'></div>

    We use the component selector, contextualized to the dialog component. The initial direct child selector (`>`) allows us to ensure we select direct children of the master component element only, and not some `.button` contained within the content region.

    **The selectors on the component are always based on the component context and carefully written to work no matter what content is in the other regions. The exact same applies to normal DOM selectors as well. This allows components to maintain modularity and portability.**

    This way, if there was a MyButton component in the content area, we wouldn't select that one by mistake. We could also have used a more unique class name than `.button` for the region div, and then selected the component as `.my-very-unique-button-class MyButton`.
    
    ***
        """
      ,
        sectionName: 'Using jQuery and Other Client Frameworks'
        markdown: """
        
    Zest is built natively without any client framework. The one you use is entirely up to you.

    ### Selector Library

    By default, Zest will test the native selector engine and dynamically include Sizzle if it is not up to standard. This can be used from `$z.$` for convenience. It also supports the leading direct child selector (`>`), as demonstrated in the previous section, allowing for properly contextualized DOM queries on components.

    If using a different library such as jQuery, reference this library as the main selector library with the RequireJS configuration:

    ```javascript
    {
      map: {
        '*': {
          selector: 'jquery'
        }
      }
    }
    ```

    This way Sizzle doesn't need to be loaded twice unnecessarily. `$z.$` will then reference jQuery instead and it will be included in the core build.

    ### Adding jQuery
    
    An easy way to install jQuery is with Volo - just type the following from the base project folder:
    ```
      volo add jquery
    ```
    
    Then add jQuery as a RequireJS dependency to the components that need it:
    
    button9.js:
    ```javascript
      define(['zest', 'jquery', 'css!./button'], function($z, $) {
        return {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(el, o) {
            var clickEvent = $z.fn();
            $(el).click(clickEvent);
            
            return {
              click: clickEvent,
              dispose: function() {
                $(el).unbind();
              }
            };
          }
        };
      });
    ```
    
    And just to prove it works:
    ```jslive
      $z.render('@app/dialog5', {
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-19'));
    ```
    <div class='container-19' style='margin: 20px'></div>

        
    ### Converting jQuery Plugins into Render Components
    
    It is straightforward to convert jQuery plugins to work with Zest rendering by loading the plugin as a dependency.
    
    The CSS and HTML template get gathered together as the render component. What would have been a 'domready' or 'attachment' code becomes this attachment function, and the controller can be returned.
    
    Most plugins aren't designed for RequireJS usage - for these needs, use the [RequireJS shim config](http://requirejs.org/docs/api.html#config-shim) to tell RequireJS how to load the plugin, and what global it defines.
        
        """
      ,
        sectionName: 'Loading Data'
        markdown: """
        
    Up until now we've assumed that all data for rendering is provided with the initial render call. This is a good way to go about
    things in many cases, but it is also possible for components to do their own loading.
        
    For this, there is one other property a render component can define. That is it (its only 6 in total).
    
    This is the `load` function.
    
    The load function is used to preprocess options data before rendering, as well as to load data from other services.
    
    The load function can be both synchronous (one argument) and asynchronous (two arguments).
    
    It takes the following form:
    
    ```javascript
      function load(o)
      function load(o, done)
    ```
    
    In the asynchronous case, the load function must call the `done` function otherwise rendering will pause indefinitely.
    
    > To install [rest](https://github.com/guybedford/rest) with Volo, use `volo add guybedford/rest`.

    The asynchronous load is very useful when combined with the an HTTP module like [rest](https://github.com/guybedford/rest). This provides an HTTP implementation which works with the same API on both the browser and the server.
    
    As a very rough example, consider a component which uses a local server service to load data:
    
    ```javascript
      define(['rest/json'], function(json) {
        return {
          options: {
            dataUrl: '/products'
          },
          load: function(o, done) {
            json.get(o.dataUrl, function(data) {
              o.productList = data.products;
              done();
            }, function(err) {
              o.error = 'Error loading products!'
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

    CoffeeScript makes render components much easier to work with as cumbersome return calls and curly braces can be omitted. The multi-line string support with interpolation makes the templates easier to write, and the code looks nicer in general.
    
    button.coffee:
    ```coffeescript
      define ['zest', 'jquery', 'css!./button'], ($z, $) ->
        type: 'MyButton'
        options:
          text: 'Button'
        render: (o) -> "&lt;button>&#35;{$z.esc(o.text, 'htmlText')}&lt;/button>"
          
        attach: (el, o) ->
          clickEvent = $z.fn()
          $(el).click clickEvent

          click: clickEvent
          dispose: -> $(el).unbind()
    ```
    
    dialog1.coffee:
    ```coffeescript
      define ['cs!app/button', 'css!./dialog'], (Button) ->
        type: 'SimpleDialog'
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

        attach: (el, o) ->
          MyButton = $z.select '>.button MyButton', el
          MyButton.click.on -> $z.dispose el
    ```
    

        
    With the RequireJS CoffeeScript plugin we simply add the `cs!` prefix to the module ID:
    
    ```jslive
      $z.render('@cs!app/dialog1', {
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-20'));
    ```
    <div class='container-20' style='margin: 20px'></div>

    ***
        """
      ,
        sectionName: 'Dynamic CSS'
        markdown: """
        
    Often it can be useful to define dynamic CSS styles on an element. In the case of the dialog, the width and height could be options for rendering.
    
    Since this is only being used for dynamic instance-specific CSS, this is exactly the sort of situation inline styles are designed for.
    
    We must always ensure that we correctly escape the CSS taken from options, either using the `cssAttr` or `num` escaping methods.
    
    This is demonstrated with CoffeeScript, because it is much neater than the JavaScript equivalent:
    
    dialog2.coffee:
    ```coffeescript
      define ['zest', 'cs!app/button', 'css!./dialog'], ($z, Button) ->
        type: 'SimpleDialog'
        options:
          width: 400
          height: 300
        render: (o) -> &quot;&quot;&quot;
          &lt;div style="
            width: &#35;{$z.esc(o.width, 'num', @options.width)}px;
            height: &#35;{$z.esc(o.height, 'num', @options.height)}px;
          ">
            {&#96;content&#96;}
            &lt;div class='button'>{&#96;button&#96;}&lt;/div>
          &lt;/div>
        &quot;&quot;&quot;
        
        button: (o) ->
          render: Button
          options:
            text: o.confirmText

        attach: (el, o) ->
          MyButton = $z.select '>.button MyButton', el
          MyButton.click.on -> $z.dispose el
    ```
    
    Notice the use of the second escaping argument, `@options.width`. This is the equivalent of writing `this.options.width` in JavaScript. We are
    passing the default options width from the component into the escaping function, so that if the value is not a number, the default
    can still be used.
    
    ```jslive
      $z.render('@cs!app/dialog2', {
        width: 'asdf',
        height: 300,
        confirmText: 'Ok',
        content: '&lt;p>content&lt;/p>'
      }, document.querySelector('.container-21'));
    ```
    <div class='container-21' style='margin: 20px'></div>
    
        """
      ,
        sectionName: 'Sharing and Packaging Components'
        markdown: """

    To share our component, we can create an archive containing our project files just for that component:

    ```
      -dialog.js
      -button.js
      -button.css
      -dialog.css
      -package.json
    ```

    There are then a number of different ways to use package-management to share the component.

    The most simple is purely to upload this directly to GitHub and then allow others to download the archive.

    Since all the files are written with relative dependencies, it is entirely portable and can be loaded from any folder.

    ### Volo

    To share the component with Volo, we'd typically add a list of dependencies to our `package.json`. The dependencies
    we have are `jquery`, `require-cs` (for CoffeeScript) and `zest`. So we can write that as:

    package.json:
    ```javascript
    {
      "name": "button-and-dialog",
      "version": "0.0.1",
      "volo": {
        "dependencies": {
          "jquery": "jquery",
          "require-cs": "jrburke/require-cs",
          "zest": "zestjs/zest"
        }
      }
    }
    ```

    That's all we need to do. Now anyone can type the following from their project root:

    ```
      volo add your_github_name/button-and-dialog
    ```

    And it would install a folder `button-and-dialog` into their library folder, and also download jQuery, zest and require-cs.

    They would then be able to render the dialog from the module ID, `cs!button-and-dialog/dialog`.

    > If you create a template for other package managers, please submit a pull request to the template repo.

    ### Other Options

    There are a variety of package managers available to use. For example, you could use [Bower](https://github.com/twitter/bower). 
    The Zest template is customised most readily to Volo, but it is easy to adjust the template for other package management 
    systems.

    ### Next Steps

    The next chapter covers the eventing model in more detail and how to create components that can be extented. 

    There's no need to read the chapters in order. Feel free to jump to the [Server Rendering](#Zest%20Server) chapter to render these components on the server, or the [Building](#Building) chapter to optimize the site for production.

        """
      ]
    ,
      chapterName: 'Zest Object Extension'
      sections: [
        sectionName: 'Its all about Objects'
        markdown: """

    Zoe provides a natural JavaScript inheritance framework that was designed with dynamic controller interactions from the
    start. It is a small dependency of Zest, but using it in your own code is entirely optional.

    The idea is that Render Component controllers should use extensible prototypal inheritance.

    In this way, Render Components can be extended - I can have a very abstract slideshow render component and controller, 
    that gets extended into something more specific, say with a specific toolbar and colour scheme.

    The entire process is designed around natural JavaScript object extension.

    The inheritance model is based on three functions:

    * **zoe.fn**: _Generates a function chain event instance. Used for eventing and many other purposes as well._
    * **zoe.extend**: _Extends a host object with properties from a new object. Uses extension rules to provide 
      different extension for different properties._
    * **zoe.create**: _The inheritance model. Creates a class instance from a definition, using the object extension system
      with some extra hooks as well._

    For component controllers, the inheritor, `$z.Component` is provided to easily create Render Components.

        """
      ,
        sectionName: 'Controllers as Object Constructors'
        markdown: """

    Previously, the attach function from our `button` Render Component was the following:

    ```javascript
      function (els, o) {
        _clickCallback = function(){}
        $(els).click(function() {
          _clickCallback()
        });

        return {      
          setClickCallback: function (callback) {
            _clickCallback = callback
          },
          dispose: function() {
            $(els).unbind()
          }
        };
      }
    ```

    It's quite difficult to read the above, because we've hidden the controller itself right inside this function call. The controller is **implicitly** created
    through code, instead of being **explicitly** written and easy to read.

    The other thing we can do better is save memory between controllers. If we have many buttons on the page, there is no reason we can't share the button controller
    class between all the buttons at the same time. This is exactly what the JavaScript Object Constructor is for.

    So let's create a nicer-looking controller then. For now, lets see how we'd define it when using the separate attach module:

    button-controller.js
    ```javascript
    define(['jquery'], function($) {
      var buttonController = function(els, o) {
        this.$button = $(els);
        var self = this;
        this.$button.click(function() {
          self.clickCallback();
        });
      }
      buttonController.prototype.setClickCallback = function(callback) {
        this.clickCallback = callback;
      };
      buttonController.prototype.dispose = function() {
        this.$button.unbind();
      }
      return buttonController;
    });
    ```

    We can then reference our attach property on the render component to `'./button-controller'`.

    Now when attachment happens, the attach function itself is a `constructor`. It constructs an instance of `buttonController`, with the prototype methods provided, and the
    `this` keyword referencing the new instance. The `setClickCallback` and `dispose` methods are shared between all class instances saving memory.

    ### Sugaring the Object Constructor

    There are many ways to sugar the constructor creation above. ZOE provides one way, using a `$z.Constructor` inheritor.

    So we can rewrite our button controller as:

    button-controller.js
    ```javascript
      define(['zoe', 'jquery'], function(zoe, $) {
        return zoe.create([zoe.Constructor], {
          construct: function(els, o) {
            this.$button = $(els);
            var self = this;
            this.$button.click(function() {
              self.clickCallback();
            });
          },
          prototype: {
            setClickCallback: function(callback) {
              this.clickCallback = callback;
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        });
      });
    ```

    We've changed the controller from an **implicit definition** through code to an **explicit** definition object now. 
    At a glance it is much easier to see what the `button-controller` object will look like during runtime.

    `zoe.create` creates a new JavaScript object, and then extends it with properties from inheritors, including some hooks for allowing changes
    such as mapping the `construct` method to be the constructor itself. The prototype is added to the button controller simply through standard
    object extension. The `zoe.Constructor` inheritor specifies the extension rules and hooks for this to happen.

    ### Combining the Render Component and Controller Constructor

    As one last trick, it is quite convenient to be able to write the controller and render component in the same file. It also
    makes it easier to show as examples here.

    So we can actually combine the render component and controller above back into a single button:

    button11.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
        return zoe.create([zoe.Constructor], {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els, o) {
            return new this(els, o);
          },
          construct: function(els, o) {
            this.$button = $(els);
            var self = this;
            this.$button.click(function() {
              self.clickCallback();
            });
          },
          prototype: {
            setClickCallback: function(callback) {
              this.clickCallback = callback;
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    The controller Object Constructor now also has the Render Component properties. We use the `attach` function to 
    generate an instance of the constructor itself.

    It's pure convenience that we can combine them this way without property collissions since the `prototype` 
    forms a natural separation between the two.

        """
      ,
        sectionName: 'Extending the Button'
        markdown: """

    So now we can easily extend the button to give it more functionality:

    button11-extend.js
    ```javascript
      define(['zoe', './button11'], function(zoe, Button) {
        return zoe.create([Button], {
          construct: function(els, o) {
            var self = this;
            this.$button.mouseenter(function() {
              self.hide();
            });
            this.$button.mouseleave(function() {
              self.show();
            });
          },
          prototype: {
            hide: function() {
              this.$button.stop().fadeOut();
            },
            show: function() {
              this.$button.stop().fadeIn();
            }
          }
        });
      });
    ```

    Note also that we could have included some extra CSS or other dependencies as part of the extension, which would then also
    be naturally included in the build.

    [try it here]

    When we added the `construct` property again in the extension, it was automatically added after the previous construct function, instead
    of overriding. Also the `prototype` was extended as an object with the new methods. These extension rules are all specified by the
    `zoe.Constructor` inheritor, and carry through for each successive inheritor after.

    If we still had separate Render Component and Controller parts for the button, we could have extended both parts separately,
    with the `attach` property of the extended Render Component referencing the extended controller.

        """
      ,
        sectionName: 'Controller Events'
        markdown: """

    Let's have another look at the click event on the button. Rather than a `setClickCallback` method, it makes much more sense
    to provide a dynamic hookable click event that can be triggered and listened to.

    `zoe.fn` is provided for this sort of eventing. An event handler is simply a list of functions to run when the event is triggered.
    `zoe.fn` generates a single function, which stores a list of functions in the background. When we run the function, each of
    the functions is then run in turn. We add a function to the list with the use of the `on` method.

    For example:

    ```jslive
      var clickEvent = zoe.fn();

      //add event functions
      clickEvent.on(function() {
        alert('look, its an event');
      });
      clickEvent.on(function() {
        alert('or is it a function?');
      });
      clickEvent.on(function() {
        console.log('no, its zoe.fn');
      });

      //fire the event
      clickEvent();
    ```

    It's a very simple eventing mechanism, but can also be used with different execution functions to perform
    many other tasks such as asynchronous step functions as well.

    Let's add this click event to our button:

    button12.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
        return zoe.create([zoe.Constructor], {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els, o) {
            return new this(els, o);
          },
          construct: function(els, o) {
            this.$button = $(els);
            this.clickEvent = zoe.fn();

            var self = this;
            this.$button.click(function() {
              self.clickEvent();
            });
          },
          prototype: {
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    ```jslive
      // hooks the clicke event
    ```

    It would also be quite nice if we could define the click event directly on the prototype itself.

    `zoe.Constructor` automatically detects these and creates them as instances (so that events added
    to one Button don't get added to all buttons due to our shared prototype).

    `zoe.fn` also provides a `bind` function which allows us to bind the `this` property.
    `zoe.Constructor` also binds the events directly to the constructor instance.

    The benefits of all this being that we can now write the following:

    button13.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
        return zoe.create([zoe.Constructor], {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els, o) {
            return new this(els, o);
          },
          construct: function(els, o) {
            this.$button = $(els);
            this.$button.click(this.clickEvent);
          },
          prototype: {
            clickEvent: zoe.fn(),
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    Since the event is automatically bound, we no longer need to do our own ugly binding.

    ```jslive
      [demo]
    ```

        """
      ,
        sectionName: 'Extension Notation & Rules'
        markdown: """

    To specify extend rules, like `zoe.Constructor` does, `zoe.extend` provides
    extension syntax, based on double underscores either side of the property name.

    The forms are the following:

    * **__propertyName**: _Appends the property to the existing property._
    * **propertyName__**: _Prepends the property before the existing property._
    * **__propertyName__**: _Replaces the existing property with the new property._

    The **append rule** will chain together functions just like the eventing above, it will extend objects and append
    strings and arrays.

    Similarly, the **prepend rule** will do the reverse operation.

    This is the simplest way to set inheritance extension rules.

    For example:

    ```jslive
      var Base = $z.create({
        items: ['dog', 'cat'],
        // specifies that this property should always be appended
        data: {
          some: 'data'
        },
        run: function() {
          alert(JSON.stringify(this.items));
          alert(JSON.stringify(this.data));
        }
      });

      var Extended = $z.create([Base], {
        // appends array
        __items: ['aardvark'],
        
        // object already under an append rule so these properties are added:
        __data: {
          more: 'data'
        },

        // prepend this function to go first using `zoe.fn`
        run__: function() {
          alert('this goes first');
        }
      });

      Extended.run();

    ```

    ### Extension Rules

    To specify the extension rules explicitly, add them to the `_extend` object when using `$z.create`:

    ```jslive
      var Base = $z.create({
        _extend: {
          'items': 'APPEND',
          'data': 'APPEND',
          'data.subobject': 'APPEND',
          'run': 'PREPEND'
        }
      });
    ```

    In this way, all implementations of base will follow the same extend rules, without needing
    the explicity '__' notation.

    Many other extend rules can be defined. Read the ZOE documentation for more information.

    When there is a property collision and no extension rule is specified, `zoe.extend` will display a warning
    in the console log. This should always be resolved with a rule specification as above.

    ### Using Extension Rules for the Click Event

    button14.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
        return zoe.create([zoe.Constructor], {
          type: 'MyButton',
          _extend: {
            'prototype.clickEvent': 'APPEND'
          }
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els, o) {
            return new this(els, o);
          },
          construct: function(els, o) {
            this.$button = $(els);
            this.$button.click(this.clickEvent);
          },
          prototype: {
            clickEvent: function() {
              // an initial function can be optionally provided
            },
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    By including the `_extend` rule for the clickEvent, it can now be automatically extended
    by inheritors as well as having an initial function provided.

    We could also have defined the clickEvent using the `__clickEvent:` notation instead of
    writing `zoe.fn`.

        """
      ,
        sectionName: 'Private Functions'
        markdown: """

    The most reliable and efficient way to do private methods in JavaScript is simply to define
    them as private variables.

    For private instance variables, there is no way to do this within the Object Constructor
    as variables are shared between all instances of the Constructor.

    Rather use prefixing of a with '_', to indicate a private property as is commonly accepted practise.

    Here is an example:

    button13.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {

        var privateSquare = function(num) {
          return num * num;
        }

        return zoe.create([zoe.Constructor], {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          attach: function(els, o) {
            return new this(els, o);
          },
          construct: function(els, o) {
            // as private as we can get
            this._pvtNum = privateSquare(5);

            this.$button = $(els);
            this.$button.click(this.clickEvent);
          },
          prototype: {
            clickEvent: zoe.fn(),
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    This is the recommended way of going about dealing with private methods and variables.

    Note though that private methods are inaccessible from any inheritors, making them
    very inflexible.

    If a private method may be needed by an inheritor, rather provide it on the prototype or
    instance with the underscore prefixing as above.

        """
      ,
        sectionName: '$z.Component'
        markdown: """

    $z.Component is a small base class wrapping the above concepts and also including:

    * Contextual DOM and component selectors for controllers
    * Extension rules for Render Components

    It can be used by controllers, to just provide the construction and contextual selectors,
    or it can be used by Render Components, to provide the easy extension rules, or it can
    be used by mixed Render Components and controllers.

    In this way, a simple flexible inheritance model is provided.

    Here is the code in all its glory:

    ```javascript
      $z.Component = {
        _implement: [zoe.Constructor],
        
        _extend: {
          'options': 'APPEND',
          'type': 'REPLACE',
          'pipe': zoe.fn.executeReduce(function(){ return {} }, function(out1, out2) {
            return zoe.extend(out1, out2, {
              '*': 'REPLACE',
              'global': 'APPEND'
            });
          }),
          'load': zoe.extend.makeChain('ASYNC')
        },

        _integrate: function(def) {
          if (def.construct || def.prototype)
            this.attach = this.attach || function(els, o) {
              return new this(o, els);
            }
        },
        
        construct: function(els, o) {
          this.o = o;
        },
        
        prototype: {
          $: $z.$,
          $z: $z.$z,
          dispose: zoe.fn()
        }
      };
    ```

    Don't worry too much about understanding all of the above. We haven't discussed the `_implement`, `_extend` and `_integrate` hooks.
    To delve deeper into the workings of this, read the full ZOE documentation here.

    Reading the code from top to bottom it:
    1. Implements `zoe.Constructor` for us.
    2. Provides the most obvious extension rules for the Render Component properties.
    3. Automatically gives the `attach` function as providing the instance of the component constructor.
    4. Stores the controller instance options for us on the prototype (how nice).
    5. Provides our contextual DOM selector, `this.$` and the contextual component selector, `this.$z`.

    ### Contextual Selectors

    The **contextual DOM selector** is a standard CSS selector, but restricted to the elements of the current component only.

    Elements belonging to a sub-component child of the main component will also not be picked up by the contextual selector.

    The **contextual component selector** behaves exactly as the component selector, detailed before, but again it is entirely
    restricted to the current component. It will only select first-level component children of the current component, and not
    components within a dynamic child component.


    Now is the time to mention that the entire `zoe` API (all four functions) is replicated on the `zest` object
    for convenience. So we can replace all instances of `zoe` with our `$z` object.

    So let's update our button:

    button14.js
    ```javascript
      define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
        return $z.create([$z.Component], {
          type: 'MyButton',
          options: {
            text: 'Button'
          },
          render: function(o) {
            return '&lt;button>' + $z.esc(o.text, 'htmlText') + '&lt;/button>';
          },
          construct: function(els, o) {
            this.$button = $(els);

            this.$button.click(this.clickEvent);
          },
          prototype: {
            clickEvent: $z.fn(),
            dispose: function() {
              this.$button.unbind();
            }
          }
        };
      });
    ```

    #### Common Pattern

    The above pattern becomes ridiculously common. The `construct` function "picks up" the components and elements
    we need to communicate with from this component. Then the `construct` function attaches events to the DOM and
    sub components, the events triggering through private callbacks or global events in turn on this Object Constructor.

    This pattern works very nicely for complex front ends.

    ### Render Component Extension

    The extension rules provided for the Render Component properties allow the automatic appending of
    `options`, `pipe` functions and `load` functions.

    In this way, a component can be extended with new options and new pipe properties, without conflicting
    with the previous options and pipe properties - it merely has to define these properties as if they
    weren't already there.

    Similarly, the asynchronous load function is combined so that asynchronous loads get chained together
    one after the other into a single asynchronous load function.

    All of this is provided by `zoe.fn` execution rules as part of `zoe.extend` extension rules.

    ***
        """
      ,
        sectionName: 'Diving Deeper'
        markdown: """

    Typically one can implement `$z.Component` when it suits, and not worry too much about the implementation
    details.

    If you are looking to provide extensible component parts and base classes, and want to use `zoe` as
    the inheritance system then read more about it at the ZOE documentation page.

        """
      ]
    ,
      chapterName: 'Zest Server'
      sections: [
        sectionName: 'Server Rendering Overview'
        markdown: """

    > If you only need browser rendering, skip this section and read about the build and configuration.

    As demonstrated in the Quick Start, Zest Server can be run from the single global command, `zest`. The nature of this
    execution is that the server is entirely constructed from a JSON configuration file. This makes managing RequireJS configuration
    and server parameters very simple, and allows immediate natural modularisation through server modules.

    Zest Server doesn't provide anything more than rendering. 

    Zest Server can communicate with data services either through the application or directly within component load functions
    using the provided http module.

    Alternatively, simply write a standard NodeJS application with Zest purely handling rendering. To use Zest Server outside
    of NodeJS, Zest Server can become a private HTTP rendering service.

    ### Using Zest Server within a NodeJS Application

    If you are a NodeJS developer and would rather create a conventional NodeJS application, using Zest within say Connect, there
    is a NodeJS example file called `~node-server.js` provided in the basic server template. This then consumes Zest Server
    as a dependency.

    Read about the NodeJS server format below.

    ### Using Zest Server from Outside NodeJS

    The other way that Zest Server can be used is as a **rendering service**. At its core, Zest Server is simply a mapping
    from render options to the rendered HTML, with some careful path configuration in the output to ensure URLs match to the
    correct file server. Another server application can send render requests to Zest as local HTTP requests, and 
    then in turn piping the reponse as part of its output.

    Ideally this would be packaged as a module within the other framework to make this process seamless, just as if communicating
    with a database server or session server.

    Zest Server provides a rendering mode for this purpose, which is detailed below.

        """
      ,
        sectionName: 'Setting Routes'
        markdown: """
    
    With Zest Server, all server code is split up into modules and all server configuration is contained in the `zest.json` or `zest.cson`
    (the CoffeeScript equivalent) server configuration file.
    
    So first, we need to include our module in the configuration:
    
    > Note: `zest.json` is a loosely written JSON file, so double quotes can be ommitted where not needed.
    
    zest.json
    ```javascript
    {
      port: 8080,
      modules: ['$/app'],
      require: {
        paths: {
          app: '../app'
        }
      }
    }
    ```

    By default, the server port is set to `8080`, so this can be ommitted.
    
    The '$' path is a path made by Zest which automatically maps to the route application folder. So the above tells Zest to load the
    module `[server-root]/app.js`.
    
    In app.js, we can write:
    ```javascript
    define({
      routes: {
        '/dialog1': 'cs!app/dialog'
      }
    });
    ```
    
    Navigate to [/dialog1](/dialog1) to see the above in action.
    
    So modules simply map URL patterns to components.

    The server is entirely built up from the zest.json or zest.cson file config. It is assumed that `www/lib` is the main RequireJS baseUrl, but this
    can be customized with configuration. In the `www/lib` folder, it is expected that there is an install of zest client and its dependencies
    (done with `volo add zest-client`). When using the site templates, this is already set up as required.
    
        """
      ,
        sectionName: 'URL patterns'
        markdown: """
    
    For dynamic content, typically we want part of the URL to become data parameters for the component render.
    
    For example, to allow the width and height to be set from the URL, we can use:
    
    ```javascript
    routes: {
      '/dialog2/{width}/{height}': 'cs!app/dialog'
    }
    ```
    
    Navigate to [/dialog2/1024/768](/dialog2/1024/768) or try some variations of the URL as well.
    
    URL patterns allow us to automatically map parts of the URL to the render options that we provide. In the above example,
    whenever the URL has three arguments, with the first set to `dialog2`, the initial options are set as:
    
    ```javascript
    {
      width: [second url argument],
      height: [third url argument]
    }
    ```
    
    This is why we took so much care with escaping the CSS in our dialog component properly. There are no URL variations that
    can result in injection attacks here so we are safe. But be very careful when piping options directly from the URL into the
    component, as this is a very real risk.
    
    ### Soaking up arguments
    
    Using **{argumentName*}** will soak up the current URL argument as well as all successive arguments.
    It must be the last provided argument. For example:
    
    ```
      /my/{property*}
    ```
    
    _Will map the URL `/my/full/url/string` to the options:_
    
    ```javascript
    {
      property: 'full/url/string'
    }
    ```
    
    ### Query Strings
    
    When a query string is provided, it is populated on the options properties **_queryString** and as a parsed object at **_query**.
    
    For example, the URL `/my/full/url/string?some=test&object=stuff&some=arraystoo`, for the previous route, will populate onto the options
    as:
    
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
    
        """
      ,
        sectionName: 'Dynamically Setting Render Options'
        markdown: """
    There is only so much that can be done with direct options mapping. Typically we need a page component that
    will be able to read the options, load the data and populate the page accordingly.

    We can save this page component as a separate file and load it instead, or we can write it inline within
    the routes file in the following form:

    ```javascript
      routes: {
        '/dialog3': {
          structure: Dialog,
          options:
            closeButton: true,
            content: ['&lt;p>dialog&lt;/p>'],
            width: 400,
            height: 100
        }
      }
    ```

    Notice that instead of `render` we are using the keyword `structure`. This is the only place we do this.

    The reason is that the object here is not a renderable, but the **page template render options**.

    The page template sets up the RequireJS configuration, in the HTML template, and loads the `structure`
    option as the body of the page.

    Try this out here: [/dialog3](/dialog3).

        """
      ,
        sectionName: 'Setting Page Meta-Information'
        markdown: """

    We can use the page options object to alter the page meta information as well.

    Some useful options are:

    * **title**, String: _Sets the title of the page._
    * **requireMain**, String: _Sets the `data-main` entry point for RequireJS._
    * **typeAttribute**, String: _Sets the main attribute to use for component type attribute names. Set this to `data-component` to switch
      to XHTML-compatible syntax._
    * **requireConfig**: By setting properties here, page-specific RequireJS configuration can be provided, over
      the defaults already set by Zest.
    
    So we can now set the title on our dialog page:

    ```javascript
      routes: {
        '/dialog4':
          title: 'Dialog Page',
          structure: {
            render: Dialog,
            options: {
              closeButton: true,
              content: ['&lt;']
            }
          }
      }
    ```

    Live demo: [/dialog4](/dialog4).

        """
      ,
        sectionName: 'RequireJS Configuration'
        markdown: """

    ### Global Configuration

    To add RequireJS configuration such as `map` and `paths` configs, simply ammend the `require` configuration object
    in the `zest.cson` or `zest.json` configuration file.

    This RequireJS configuration is identical to the RequireJS documentation. Zest Server will then populate the minimum
    defaults necessary on top of this, such as `baseUrl` and the Zest Client paths.

    So for example, to add a custom map config, add the following to `zest.json`:

    ```javascript
    {
      require: {
        map: {
          '*': {
            'custom-alias': 'my/custom/module'
          }
        }
      }
    }
    ```

    ### Environment Configuration

    This configuration will be shared equally between the _client_, _server_ and _build_ environments. To add specific
    configuration for these environments, the special properties `client`, `server` and `build` on the require object 
    can be set to custom RequireJS configurations.

    The configuration is extended from the base defaults up to the most specific environment settings.

    Thus, to entirely ignore our module above when running on the server, we can add the following to `zest.json`:

    ```javascript
    {
      require: {
        server: {
          map: {
            '*': {
              'custom-alias': 'empty'
            }
          }
        }
      }
    }
    ```

    ### Route Configuration

    The RequireJS configuration can also be varied at the route-level, using the `requireConfig` page meta option.

    For example, to set a map config for our dialog page only:

    ```javascript
      routes: {
        '/dialog5':
          title: 'Dialog Page',
          requireConfig: {
            map: {
              '*': {
                'custom-alias': 'my/module'
              }
            }
          },
          structure: {
            render: Dialog,
            options: {
              closeButton: true,
              content: ['&lt;']
            }
          }
      }
    ```

    This configuration will then in turn be merged with the default and client global configurations.

        """
      ,
        sectionName: 'Server Module Route Handlers'
        markdown: """

    Zest Server is simply a NodeJS server. We can write request handlers within modules using the standard NodeJS 
    style.

    The module property for this is:
    
    ```javascript
      routeHandler: function(req, res, next);
    ```

    This function sits on the module object and will be triggered **only** if the module is responsible for the current
    page.

    To add global handlers that trigger for all requests in the entire application, use:

    ```javascript
      handler: function(req, res, next);
    ```

    `req` and `res` are the standard NodeJS request and response objects. `next` is the callback for the next handler,
    that must be called otherwise the server will hang.

    There are three `req` properties that are set by Zest Server:
    * **redirect**: _The URL to 301 redirect to. Takes precedence over the page render._
    * **pageOptions**: _The page meta options used for rendering the page component, exactly as in the page meta section before.
    * **pageTemplate**: _The page template module ID, as loaded from configuration._

    The handlers are triggered after performing routing, so that the above properties are all populated already.
    The handlers can then make any adjustments to these properties giving them full control of the server.

    When none of `redirect`, `pageOptions` and `pageTemplate` are set, the next fallback is the file server, followed by
    a page not found notice. This should always be avoided using a final catch-all route of the form `/{404*}` in the
    application.

    For example, we can set RequireJS configuration from the routeHandler:

    ```javascript
      routes: {
        '/dialog5':
          title: 'Dialog Page',
          structure: {
            render: Dialog,
            options: {
              closeButton: true,
              content: ['&lt;']
            }
          }
      },
      routeHandler: (req, res, next) {
        if (req.pageOptions)
          req.pageOptions.requireConfig.map['*']['my-alias'] = 'my/module';
      }
    ```

        """
      ,
        sectionName: 'Overriding the Page Template'
        markdown: """

    To allow for more changes in the underlying page template (meta properties, etc), we need to override the existing 
    page template with a custom one.

    The page template used by Zest Server is by default `cs!$zest-server/html`. This is a CoffeeScript component, called
    `html.coffee` located in the Zest Server folder under `node_modules`.

    The page is on GitHub here - <https://github.com/zestjs/zest-server/blob/master/html.coffee>.

    ### Global Page Template

    We make a copy of this into our base application folder with the same name.

    Then set the `pageTemplate` configuration option in Zest:

    zest.json:
    ```javascript
    {
      pageTemplate: 'cs!$/html',
      modules: ['$/app'],
      require: {
        paths: {
          app: '../app'
        }
      }
    }
    ```

    This will now use out local `html.coffee` as the main page template component.

    We can now modify the HTML and add meta properties and extra options as necessary, treating it just like any other
    component.


    ### Module Page Templates

    The page template is available for changes by modules within the routeHandler, as documented previously.

    Thus to change the page template for a specific module, override it directly:

    ```javascript
    define({
      routes: {
        '/': 'some/component'
      },
      routeHandler: function(req, res, next) {
        req.pageTemplate = 'cs!$/module-html'
      }
    });
    ```

    If the page template is a relative dependency to the module, load it as a dependency and then pass the object
    directly as the page template, instead of as a string.


        """
      ,
        sectionName: 'Asynchronous Streaming and Deferred Titles'
        markdown: """

    To demonstrate the asynchronous streaming used by Zest Server, lets stream our dialog now:




    
    For testing the latency of rendering for a slow page load, there is also the `renderDelay` configuration option.
    This specifies a delay in ms to wait before each Render Component is rendered. Useful for inspecting how the site
    will behave with partial loading.

    For slow file loading, a `staticLatency` configuration option can also be set allowing for a delay in the file
    server as well.

    So an example slow page test configuration could be:

    ```javascript
    {
      environments: {
        'dev-slow': {
          staticLatency: 500,
          renderDelay: 500
        }
      }
    }
    ```

        """
      ,
        sectionName: 'Quick Refresh'
        markdown: """

    When developing, one often makes regular changes to files and the server needs to be reloaded. Nodemon is a great
    application for allowing automatic server refreshing.

    Zest Server supports nodemon for a quick development cycle.

    Install Nodemon with NPM:

    ```
      npm install nodemon -g
    ```

    Then start Zest Server with the special nodemon form:

    ```
      zest start-nodemon
    ```

    Now Zest Server will automatically restart everytime a component file is changed. The server is quick enough that this
    can allow a fast refresh cycle.

        """
      ,
        sectionName: 'Adding Middleware'
        markdown: """

    With full access to the request and response objects, the modules can thus add Middleware to the application if necessary.

    If using connect, add this as a module dependency. As long as there is no RequireJS module called 'connect', RequireJS
    will fall back to loading this as a NodeJS dependency.

    For example, to load Connect middleware and session management (after installing connect - `npm install connect`)
    within a module, one can do:

    ```javascript
      define(['zest', 'connect'], function($z, connect) {
        // create the step function for combining handlers
        var urlHandler = $z.fn('ASYNC');

        // connect needs the 'originalUrl' property to be set
        urlHandler.on(function(req, res, next) {
          req.originalUrl = req.url;
          next();
        });
        
        // add middleware
        urlHandler.on(connect.limit, '5.5mb');
        urlHandler.on(connect.cookieParser());
        
        sessionStore = new connect.session.MemoryStore();
        urlHandler.on(connect.session, {key: 'sid', secret: 'secret', store: sessionStore});
        
        urlHandler.on(connect.json());
        urlHandler.on(connect.urlencoded());
        urlHandler.on(connect.multipart());

        urlHandler.on(function(req, res, next) {
          // do something with the session data
          req.pageOptions.sessionVar = req.session.var;
        });
        
        return {
          routeHandler: function(req, res, next) {
            // run route handler
            urlHandler(req, res, next);
          }
        };
      });
    ```

    The `req.session` will then be populated with modifiable session data, whenever the page route is matched by this module.

        """
      ,
        sectionName: 'Using Zest Server within a NodeJS Application'
        markdown: """

    To execute Zest Server from the basic server template, first install `connect` with the following:
    ```
      npm install connect
    ```

    Then simply type:
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

    The `zest.init` method loads the zest configuration in the 'dev' environment from the Zest configuration file 
    and also configures RequireJS.

    The configured RequireJS loader can be accessed from the `zest.require` function:
    ```javascript
      zest.require([deps], callback);
    ```

    To access the zest render function directly and bypassing the routing, one can use:
    
    ```javascript
      zest.render(pageTemplate, pageOptions, res);
    ```

    The render function will render the provided page template, with the provided page options, into the response object,
    as documented previously.

    Note that it will close the response after rendering, so that it should always be rendering an entire page template.

        """
      ,
        sectionName: 'Changing File Paths and File Server Settings'
        markdown: """

    When using Zest Server from within NodeJS you may wish to change the file folders around.

    The following configuration options are provided for this:

    * **publicDir**: _The public folder. Defaults to 'www'._
    * **publicBuildDir**: _The public built folder. Defaults to 'www-built'._
    * **baseDir**: _The base js folder relative to the public folder. Defaults to 'lib'_.

    The file server provides the following options:

    * **serveFiles**: _Boolean indicating if file server is enabled. Defaults to true._
    * **fileExpires**: _The cache duration time for the files in seconds._
    * **staticLatency**: _An optional delay when serving files. Useful for a 'dev' environment when testing with latency._

        """
      ,
        sectionName: 'Using Zest Server as a Rendering Service'
        markdown: """

    There is a `core-module` provided with Zest Server, that simply acts as a rendering service. Note that if your application
    contains unsecure components (directly writing unescaped HTML from options), then this service will be unsecure. Typically
    this service should only be enabled on a private server or during development.

    The core module is loaded with the following:

    zest.json
    ```javascript
    {
      modules: ['$zest-server/core-module']
    }
    ```

    Once enabled, it responds to the following route:

    ```
      /component/...componentId...?...componentOptions...
    ```

    For example, our lovely dialog component can be viewed at:

    ```
      /component/cs!app/dialog?closeButton=true&content=hello%20world
    ```

    If query strings aren't your thing, there is also a POST service available to the same URL. The POST data should then
    contain the JSON rendering options.

        """
      ]
    ,
      chapterName: 'Building'
      sections: [
        sectionName: 'Running the Build'
        markdown: """

    As mentioned in the Quick Start, running the build in the _client template_ involves typing:

    ```
      r.js -o build.js
    ```

    and running the build on the _server template_ is to simply start the server in the production environment:

    ```
      zest start production
    ```

    If loading Zest Server in NodeJS, then pass the "production" environment name to the `zest.init` method.

    The RequireJS optimizer will display the build log detailing all files built and their contained dependencies.

    The build involves copying the entire public folder, `www` to a new built public folder, `www-built` containing
    the minified and built equivalents of all files. This is entirely handled by the RequireJS Optimizer.

        """
      ,
        sectionName: 'Configuring the Build'
        markdown: """

    To understand the build process it is recommended to read the RequireJS Optimizer documentation. A very brief overview
    is given here.

    In the _client template_, the build configuration is located in the file `build.js`.

    In the _server template_, the build configuration is located as the configuration item `require.build` in the
    `zest.cson` or `zest.json` configuration file.

    The primary build specifier is the `modules` array which specifies the array of modules to build to the r.js Optimizer.

    Each array item typically contains the following properties:
    
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

    The `moduleName` is a RequireJS module ID for a module to build. When a module is built, its file is minified and ammended
    along with all of its dependencies so that the entire module can be loaded from that single file.

    To create a custom build module the `create: true` parameter can be set, which allows the ability to specific exactly
    which modules to build.

    `include` and `exlude` then provide arrays of moduleIds to include and exclude from the built module. Both of these are done
    recursively - each include module is included along with all its dependencies, and exclude modules excluded along with all 
    their dependencies.

    Exclude items can also be other layers in the modules list. In this way, we can have a core module containing the
    scripts used by most pages of the application, and then page-specific modules which contain just the extra scripts
    needed for pages.

    Let's create the build for our dialog:

    in `require.build` configuration for the server, or `build.js` for the client example:
    ```javascript
    {
      modules: [
        {
          name: 'dialog'
        }
      ]
    }
    ```

    include the exclude of coffee script etc. and then include an example test page (the site will be!)

        """
      ,
        sectionName: 'Render Component Controller-Only Attachment Builds'
        markdown: """

    When running a build of a Render Component, the build will typically contain the template (compiled if using a template
    loader plugin), CSS or compiled LESS, the compiled CoffeeScript it was written in CoffeeScript, as well as any dependencies.

    This is all assuming that we want the **entire** Render Component. That is, the ability to render that Render Component
    on the client.

    But if the component was rendered from the server, it makes no sense to package the render code as well. We only need to
    package the CSS, compiled LESS and controller code, as well as the attachment of any sub components used in regions.

    To automatically package everything except the render code, we can use the `$attach` plugin provided by Zest.

    In Zest Client, the attach plugin is located at `zest/attachment`.

    In place of a build id, we then specify:

    ```
      include: ['$attach!my/component/id']
    ```

    This doesn't conflict with a full build of the component, so that if another module needs the full component there will
    be no build conflict or duplication.

    Note that the attachment can only separate the render code from the controller code, when the components have been
    with separate `attach` modules of the form:

    ```javascript
    define({
      render: '...',
      attach: './my-controller-id'
    });
    ```

    When there isn't a separate controller Id as above, the attachment build will be the same as the full build anyway,
    although component dependencies will also be included with their attachment builds.

        """
      ,
        sectionName: 'Zest Server Layering'
        markdown: """

    #### Core Zest Layer

    If using Zest Server, the core layer is already created automatically, containing the build of the Zest files.

    This layer is called `zest/build-layer`.

    We can add to this layer using the specical configuration items:

    ```javascript
    {
      zestLayerInclude: [moduleIds]
      zestLayerExclude: [moduleIds]
      zestLayerExcludeShallow: [moduleIds]
    }
    ```

    #### Exclude Layer Helper

    Another layer is also generated, called `zest/excludes`. This is an exclusion-only layer which should be applied to
    all layers you create in order to 



    In this way we can ammend the core build to ensure that our entire site is loaded from a single file, while having
    the standard build configurations automatically populated.

    Typically one only needs to add the following in the server configuration for it all to just work:
    ```javascript
      zestLayerInclude: ['$attach!my/page/component']
    ```

        """
      ,
        sectionName: 'Optimized Page Loading with Zest Server'
        markdown: """

    ### Layer Loading

    When using multiple layers on a page, there are different ways to go about loading the layers. Instead of just
    throwing all the layers into `<script>` tags at the top of the page, layers can be carefully loaded for an optimal
    page load.

    To allow for efficient layer loading, the Zest Server page template has a `layers` array option. This is the array
    of layers to use with the current page. By default the `zest/build-layer` layer is already included. When using additional
    layers on the page, add them to this array in the configuration file or through the page options in the module.

    The layer loading process is based on RequireJS best-practise:

    1. When running the build, Zest Server stores the built file dependencies so that it has a full list of all layer dependencies.
    2. When including a layer in the page, Zest Server adds RequireJS paths configurations mapping each of the dependencies for that
     layer to the layer itself. _The layer is thus not loaded by default, but loaded as soon as a request is made to a dependency
     that refers to a layer._ The paths configuration ensures that the dependency is always loaded from the correct layer and never
     directly.

     
    ### Understanding the Page Load and Inline Requiring

    This is all good and well, but since loading is asynchronous, that means there will be a delay in displaying resources and dynamic
    scripts while these layers are loaded. The user could be seeing unstyled content and unattached render components in this time.

    To solve this problem, [require-inline](https://github.com/guybedford/require-inline) is used to provide a synchronous 
    requiring mechanism while the page is being displayed.

    It is an addon to RequireJS that is fully compatible with all module loads, blocking the page display while the load is made.

    Loading a stylesheet or module with require-inline is thus equivalent to using a blocking `<link>` or `<script>` tag, but providing
    the full RequireJS API load.

    The way Render Components are loaded is with a **require-inline** call before the component, ensuring that the styles for
    the component have loaded. If the css dependency maps to a layer, then that layer will be sychronously downloaded at this point
    as it is the critical resource blocking the current page display.

    This is followed by the HTML for the render component. Any sub-render components will also have the same process running on them,
    so that by the time all the HTML for this component has loaded, all its sub components will be fully loaded first.

    Immediately after the component HTML, is another **require-inline** call which ensures the component controller is fully
    loaded, before the attachment is performed.

    In this way, any visible HTML will always be styled, and it will be entirely possible to interact with components before
    the page load has even completed.

    When optimizing the page load, it is important to carefully consider layers such that this interactive load is as quick as possible,
    and using as few layers as possible. If there are parts of the page outside of the layer they will be requested with separate
    requests. By checking the network tab, these can be found and then added back into the layer. The goal should be for all of the
    page controllers and scripts to sit within a layer.

    In this way, full control over the page load dependencies is given based on the critical load requirements. This allows
    for creating highly optimized sites with minimal development effort.
        """
      ]
    ]