define ['cs!./doc-page/doc-page', 'zoe'], (DocPage, zoe) ->
  render: DocPage
  options:
    title: 'zoe - Zest Object Extension'
    section: 'zoe'
    data: [
      chapterName: 'Zoe - Zest object extension'
      sections: [
        sectionName: 'Introduction'
        markdown: """
          Zoe developed out of a need to manage the inheritance of dynamic components.
          Many JavaScript inheritance systems bring classical inheritance systems, while
          the approach taken here is to create an inheritance model that naturally works with JavaScript objects.
          
          The basic principle is that inheritance is a form of object extension, thus the inheritance system of [`zoe.create`](#zoe.create) builds directly
          out of the extension system in `zoe.extend`. Zoe is a relatively small library (6KB minified, unzipped), for the inheritance power it brings.
          
          In plain English, `zoe.extend` simply extends one object with the properties of another. The rest of its code deals with how to
          manage property clashes. The idea being that you can specify property extension rules on a per-property basis. A sub object might
          itself be extended again providing a deep extension, while a string might be replaced.
          
          When extending a function with another function, you may want to run the functions together. From here the idea of 'function chains'
          grew, where the extension rule on functions allows for an eventing paradigm. Exploring these ideas further lead to the creation
          of `zoe.fn`.
          
          `zoe.create` brings these all together allowing for flexible inheritance in JavaScript fully compatible with prototypal inheritance (provided by the [zoe.Constructor](#zoe.Constructor) base class).
          
          At the end of the day, it works in the background, with rules specified by the creators of classes designed to be used in inheritance.
          
          For those implementing the classes, they merely need to use them, without any understanding of the underlying processes.
          
          The documentation here is primarily for those interested in creating extensible base classes for components, and understanding
          the details of this process.
          
          For a more basic introduction, see the zest.Component documentation, which explains the basics of this inheritance model from
          a more practical perspective.
        """
      ]
    ,
      chapterName: 'zoe.fn'
      sections: [
        sectionName: 'zoe.fn'
        markdown: """
  _Flexible function composition_
  
  **zoe.fn deals with creating and managing the execution of arrays of functions or 'function chains'.**
  
  Use cases:
  
  1. Registering an **event** callback means ammending a function to a list of functions
      to be executed when an event triggers.
  2.  Just like events, any **pub/sub system** is based on adding a callback function to the
      list of functions to be executed on a signal.
  2.  **Asynchronous step functions** involve running a list of functions, but only
      starting the next one once the previous one has sent a complete callback.
  3. **Logic filters** involve function composition where outputs are logically combined.
  
  The idea of `zoe.fn` is to create a low overhead system for managing events. _Instead of external event registration and triggering, the function itself is both the event and the trigger, with its own methods to handle event registration_.
  
  ### Usage:
  
  ```javascript
    var f = zoe.fn(executionFunction, initialFunctions);
  ```
    * **initialFunctions, Array** (optional): _an array of the inital functions to be provided_
    * **executionFunction, string / function** (optional): _the main execution function to handle function execution and output
       when no executionFunction is provided. Defaults to [`zoe.fn.LAST_DEFINED`](#zoe.fn.LAST_DEFINED). When a string `FUNCTION_NAME` is provided, the function is loaded from `zoe.fn.FUNCTION_NAME`. These provided execution functions are detailed below._
      
  #### Instance methods:
    * `f.on(fn)`: _add a new function to the list of functions_
    * `f.off(fn)`: _remove a function from the list of functions_
    * `f.first(fn)`: _add a new function at the beginning of the list of functions_
    * `f.bind(thisVar)`: _used to permanently bind this instance to the given 'this' reference. **By default, and when passed the value `undefined`, binding is identical to natural function scope binding.**_
    * `f()`: _executes the current function list based on the given executionFunction_
      
  #### What it does:
  * zoe.fn is a factory function returning a function instance acting as a wrapper around an array of functions.
  * Additional functions can be added to the list with the use of the `on` method provided to the instance.
  * The list of functions in the chain are all called when calling the instance function itself.
  * The default execution function computes all the functions one after another. This can be specified to provide different execution behaviors.
  
  #### Eventing Example:
  
  > This is a live code example. Click 'run' to execute the code. You can also edit the code in this box if you wish to change it.
  
  ```jslive
    var clickEvent = zoe.fn();
    
    clickEvent.on(function(type) {
      alert('click event fired: ' + type);
    });
    clickEvent.on(function() {
      alert('another hook');
    });
    clickEvent.first(function() {
      alert('this hook runs first');
    });
    
    clickEvent('left click');
    //outputs:
    // 'this hook runs first'
    // 'click event fired: left click'
    // 'another hook'
  ```
   
    This is the event model used by the Zest component framework.
   
    ***
   
    ### Execution Functions
   
    The major flexibility provided by zoe.fn is that the execution function can be entirely customized. The execution function takes the following form:
   
    ```javascript
      executionFunction = function(self, args, fns) {
        return output;
      }
    ```
   
    * **self, Object**: _the 'this' scope to use_
    * **args, Array**: _the array of arguments (already converted to a proper JavaScript array)_
    * **fns, Array**: _the array of functions to execute_
   
  It is the responsibilty of the execution function to determine which functions to run,
    when to run them, with what arguments and scope, and what final output to provide.
      
    #### Example:
    
    > This is a live code example. Click 'run' to execute the code. You can also edit the code in this box if you wish to change it.
    
    ```jslive
      var EXECUTE_LAST_ONLY = function(self, args, fns) {
        fns[fns.length - 1].call(self, args);
      }
      
      var f = zoe.fn(EXECUTE_LAST_ONLY);
      
      f.on(function() { alert('first'); });
      f.on(function() { alert('second'); });
      
      f();
    ```
        """
      ,
        sectionName: 'zoe.fn.LAST_DEFINED'
        markdown: """
  _Executes all functions in the chain, returning the last non-undefined output._
  
  #### Example:
  ```jslive
    //interchangeable with zoe.fn(zoe.fn.LAST_DEFINED)
    var f = zoe.fn('LAST_DEFINED'); 
    
    f.on(function() { return 'first function'; });
    f.on(function() { return 'second function'; });
    f.on(function() { alert('third function'); });
    
    f(); //returns 'second function'
  ```
        """
      ,
        sectionName: 'zoe.fn.STOP_DEFINED'
        markdown: """
  _Runs the execution of fns, until one function returns a non-undefined output. Then no further functions are executed._

  #### Example:
  ```jslive
    var f = zoe.fn('STOP_DEFINED');
    
    f.on(function() { alert('first function'); });
    f.on(function() { return 'second function'; });
    f.on(function() { alert('this never runs'); });
    
    f(); //returns 'second function'
  ```
        """
      ,
        """
        sectionName: 'zoe.fn.ASYNC'
        markdown: """
  _Executes the asynchronous functions in series, before the final complete callback._
  
  **This is an implementation of the asynchronous step function pattern.**
  
  Each function must have the form:
  ```javascript
    fn(arg1, arg2, ..., next)
  ```
  
  If the function never calls `next`, then the next callback won't happen. No error will be thrown.
  
  The instance function takes the form:
  ```javascript
    f(arg1, arg2, ..., complete)
  ```
  
  * **arg1, ...** (optional): _Any arguments to send to each callback function (before the `next` argument)._
  * **complete, function** (optional): _If the last argument in the instance function is a function, it is assumed as the complete function. Each function in the chain will get the exact same arguments._

  The allows for the creation of an asynchronous step function, with the
  last argument to each successive function being the 'next' callback
  into the next function or final completion.
  
  #### Example:
  
  ```jslive
    var f = zoe.fn(zoe.fn.ASYNC);
  
    f.on(function(message, next) {
      setTimeout(next, 2000);
    });
  
    f.on(function(message, next) {
      alert(message);
      next();
    });
  
    f('howdy', function() {
      //complete function optional
      alert('complete');
    });
  ```
  
  #### Example - NodeJS Server Handler
  
  Server handlers in NodeJS are also simply step functions of this form. Thus we can write a server in NodeJS as:
  
  ```javascript
    var http = require('http');
    var handler = zoe.fn('ASYNC');
    
    http.createServer(handler).listen(8080);
    
    handler.on(function(req, res, next) {
      if (req.headers['Content-Type'].indexOf('application/json') != -1) {
        //handle an application request
      }
      else
        next();
    });
    handler.on(function(req, res, next) {
      if (req.url == '/') {
        //handle a page request
      }
    });
  ```
  
  This handler mechanism is used by zest server. Handlers can then also be added and removed dynamically at runtime.
  
        """
      ,
        sectionName: 'zoe.fn.ASYNC_SIM'
        markdown: """
  *Executes the asynchronous functions in parallel (**sim**ultaneously), awaiting completion on all functions before the final complete callback.*

  As with ASYNC, except instead of calling each next function synchronously, the functions are all run
  in parallel until they have all returned, at which point the final complete callback is called.
  
  #### Example:
  
  ```jslive
    var f = zoe.fn(zoe.fn.ASYNC_SIM);
  
    f.on(function(next) {
      alert('first starting');
      setTimeout(next, 3000);
    });
  
    f.on(function(next) {
      alert('second starting');
      setTimeout(next, 500);
    });
  
    f(function() {
      //complete function optional
      alert('both completed after 3 seconds');
    });
  ```
        """
      ,
        sectionName: 'zoe.fn.executeReduce'
        markdown: """
  The above are the only execution functions provided. It is straightforward to make custom execution functions for other purposes. When building a new execution function, `zoe.fn.executeReduce` is a helper function to assist with the most common use case.
  
  _Executes all the functions, then computes the final output based on a reduction function._
  
  #### Usage:
  ```javascript
    zoe.fn.executeReduce(startVal, function(out1, out2) {
      return reducedOutput;
    });
  ```
  
  * **startVal** (optional): _The initial value to use in the reduction function._
  * **reduction, function**: _A standard reduction function, which runs from left to right._
  
#### Example:
  
  Assuming a numberical output, provide the totals of all the function outputs:
  
  ```jslive
    var TOTAL = zoe.fn.executeReduce(0, function(out1, out2) {
      return out1 + out2;
    });
    var f = zoe.fn(TOTAL);
    
    f.on(function() { return 5; });
    f.on(function() { return 10; });
    
    f();
  ```
  ***
        """
      ,
        sectionName: 'zoe.on'
        markdown: """
  Shorthand for converting any function to a chain. Effectively the duck punch pattern using zoe.fn, but if the function is already a zoe.fn, it is just added to the list (using less memory than recursive duck punching).
  
  #### Usage:
  
  ```javascript
    zoe.on(obj, method, fn);
  ```
  
  * **obj, Object**: _The object on which the function is a property._
  * **method, string**: _The function's method name on the object._
  * **fn, function**: _The new function to add to the execution list._
  
  By default, `zoe.on` uses the `zoe.fn.LAST_DEFINED` execution method when ammending a function without an execution method. The `this` scope of the function will be the natural scope, referencing the host object.
  
  If the function is already an instance of `zoe.fn`, its existing execution method and scope is kept.
  
  #### Example:
  ```jslive
    var ball = {
      bounce: function() {
        alert('bouncing');
        return 'bounced';
      }
    };
    
    //we can easily hook other functions
    //note the return value is left in tact
    zoe.on(ball, 'bounce', function() {
      alert('bounce hook');
    });
    
    ball.bounce();
  ```
        """
      ,
        sectionName: 'zoe.off'
        markdown: """
  _The corresponding unhook method for `zoe.on`._
  
  #### Usage:
  ```javascript
    zoe.off(obj, method, fn);
  ```
  
  * **obj, Object**: _The host object._
  * **method, string**: _The function's method name._
  * **fn, function**: _The exact function for removal (as previously added)._
  
        """
      ]
    ,
      chapterName: 'zoe.extend'
      sections: [
        sectionName: 'zoe.extend'
        markdown: """ 
  _Extend objA by merging properties from objB. A flexible rules mechanism allows for advanced merging functions._
  
  zoe.extend provides a JavaScript object extension mechanism, a common need. The mechanism here is built to complement the inheritance model of `zoe.create`.
  
  ### Usage:
  
  ```javascript
    zoe.extend(objA, objB, rules);
  ```
  
  * **objA, Object**: _The object to extend (the host object)_
  * **objB, Object**: _The object with the new properties to add (the extending object)_
  * **rules, function / string / Object** (optional): _A rule function or rule object map._
    * As a function, it is a **rule function** to copy each property.
      If a string, `RULE`, is specified it is assumed to refer to the rule function `zoe.extend.RULE`.
    * As an object, it acts as a **rule map** listing rule functions for each property.
    * When not provided, the rule function used is `zoe.extend.DEFINE`.
  * The return value is the host object, objA.

  The extend function traverses all the properties on `objB`, and provides a value for these properties on `objA`.
  
  Without any alternative rule, zoe.extend does a straight merge using the `zoe.extend.DEFINE` rule. This will report an
  error as soon as there is a property name clash and need for an override.
  The error made is not thrown, but is a non-critical log message. This indicates the need to specify a rule, which should always be done in this case.
        """
      ,
        sectionName: 'zoe.extend - Rule Functions'
        markdown: """
  
  When a rule function is given, it specifies the rule for copying properties from the extending object to the host object.
  
  A rule function takes the following form:
  
  ```javascript
    ruleFunction = function(valueA, valueB, rules) {
      return newValue;
    }
  ```
  * **valueA, string**: _The property value of the property on the host object._
  * **valueB, string**: _The property value for the property on the extending object._
  * **rules, Object**: _The rule map for the property. Used for deep object extension rules._
  * **newValue**: _The new value to place on the host object. If `undefined`, no value is written at all._
  
  The property name is entirely ignored by the ruleFunction. This is since the value and **rules** object are the
  only dependents in the process.
  
  #### Example:
  
  For example, `zoe.extend.REPLACE`, is the rule function defined by:
  
  ```javascript
    zoe.extend.REPLACE = function(valueA, valueB) {
      return valueB;
    }
  ```
  This will overwrite the property on the host object with the property from the extending object.
  
  The rule function can be used by specifying the rule as the third parameter to the extend function:
  
  ```jslive
    var objA = { obj: 'A' };
    var objB = { obj: 'B', another: 'property' };
    
    //extends objA with properties from objB using the replace rule
    zoe.extend(objA, objB, zoe.extend.REPLACE);
    
    //has become 'B'
    objA.obj;
  ```
        """
      ,
        sectionName: 'zoe.extend - Rule Maps'
        markdown: """
    
  A **rule map** specifies which **rule functions** to use for which object properties.
    
  ### Definition
  
    A rule map takes the form:
    ```javascript
      {
        'property': Extension Rule
        'property.sub_property': Deep Extension Rule
        '*': Wildcard Rule
        '*.*': Deep Wildcard Rule
      }
    ```
    
    * Rule Maps map object properties and subproperties to rule functions.
    * The rule function can be specified directly, or as a string `RULE` implying the function `zoe.extend.RULE`.
    * Wildcard rules are applied when no other rule is specified for the property.
    * When a property has sub rules (specified by a '.'), the rule map for the property is derived and passed as the third
      parameter to the extension function for that property. By using `zoe.extend` (or just `'EXTEND'`), this allows
      deep object extension as it conforms to the rule function specification itself.
    * Deep wildcard rules are passed down to all property rule maps, to be used just as normal wildcards at each level.
    
  #### Example
  
    ```jslive
      var objA = {
        some: 'properties',
        array_property: ['some', 'things']
      };
      var objB = {
        more: 'properties',
        array_property: ['more', 'values']
      };
    
      zoe.extend(objA, objB, {
        '*': zoe.extend.REPLACE,
        'array_property': 'ARR_APPEND'
      });
      
      //the array property contains the concatenation from objA and objB
      objA.array_property;
    ```
    
    Both `zoe.extend.REPLACE` and `zoe.extend.ARR_APPEND` are provided rule functions. Note how
    they can be referenced directly or with the shorthand string rule name only.
    
  #### Example
    
    Depth can also be specified in the rule map. For example:
    
    ```jslive
      var objA = {
        object_property: {
          str_property: 'hello'
        },
        another: 'property'
      };
      var objB = {
        object_property: {
          str_property: ' world',
          more: 'properties'
        }
      };
      
      var MY_RULE = {
        'object_property': zoe.extend, //can also use 'EXTEND'
        'object_property.*': 'REPLACE',
        'object_property.str_property': 'STR_APPEND'
      };
      
      zoe.extend(objA, objB, MY_RULE);
      
      objA.object_property.str_property;
    ```
    
    The above will use `zoe.extend` as the rule function to deep extend 'object_property' on the host object.
    
    The third parameter passed to the rule function is the derived rule map for that property. In the above example, this would be:
    
    ```javascript
      //the object_property derived rule map:
      {
        '*': zoe.extend.REPLACE,
        'str_property': zoe.extend.STR_APPEND
      }
    ```
  
    Thus, 'object_property' gets deep extended itself based on these rules.
    
        """
      ,
        sectionName: 'zoe.extend - Rule Notation'
        markdown: """
    
  ### Definition
    
    When defining a property, it can be more convenient to indicate the extension
    rule as part of the property name instead of through a separate rule map.
    
    In this case, an underscore notation can be used:
    
    * **__propertyName**: Use the zoe.extend.APPEND rule
    * **propertyName__**: Use the zoe.extend.PREPEND rule
    * **__propertyName&#95;&#95;**: Use the zoe.extend.REPLACE rule
    
  The property name is taken to be the property name without underscores.
    
  The `zoe.extend.APPEND` rule will:
  
    * Chain together functions with zoe.fn()
    * Extend objects with replacement
    * Append strings
    * Concatenate arrays
    * Replace any other property type
    
  The `zoe.extend.PREPEND` rule will:
  
    * Chain together functions as zoe.fn() chains, but first in the execution chain
    * Extend objects with the fill rule, replacing properties not already defined only
    * Prepend strings
    * Reverse concatenate arrays
    * 'Fill' any other property type (create it if not already defined)
    
  #### Example
  
    ```jslive
      var a = {
        options: {
          msg: 'hi'
        }
      };
    
      zoe.extend(a, {
        __options: {
          more: 'options',
          __msg: ' you'
        }
      });
    
      a.options.msg;
    ```
    
    This is effectively identical to:
    
    ```javascript
      zoe.extend(a, b, {
        options: 'EXTEND',
        options.msg: 'ARR_APPEND'
      });
    ```
    
        """
      ,
        sectionName: 'zoe.extend - Examples'
        markdown: """
  
  #### Cloning an object at the first level:
  
    ```javascript
      zoe.extend({}, obj);
    ```
  
  #### Cloning an object to all depths:
  
    ```javascript
      zoe.extend({}, obj, zoe.extend.DREPLACE);
    ```
  
  #### Providing default configuration on a nested configuration object:
  
    ```javascript
      zoe.extend(config, default_config, zoe.extend.DEEP_FILL);
    ```
  
  #### Custom extension with automatic type adjustment
  
    ```jslive
      var Heading = {
        template: function(text) {
          return '&lt;h1&gt;' + text + '&lt;/h1&gt;';
        },
        css: 'font-size: 12px;'
      };
      var Red = {
        css: 'color: red;'
      }
   
      zoe.extend(Heading, Red, {
        css: zoe.extend.STR_APPEND
      });
   
      Heading.css;
      //returns
      // Heading = {
      //  template: function(text) {
      //    return '&lt;h1&gt;' + text + '&lt;/h1&gt;';
      //  },
      //  css: 'font-size: 12px;color: red;'
      //};
    ```
    
    This demonstrates the primary use case for zoe.extend rules -
    the ability to have a flexible object inheritance mechanism for web components.
  
  ***
        """
      ,
        sectionName: 'zoe.extend.DEFINE'
        markdown: """
  ### Definition
    * Copies all properties from objB to objA.
    * If the property is already defined on objA, it throws an error (which causes a log message, not a critical break).
    * This is the default rule for extension when no other rule is specified.
    
  #### Example
  ```jslive
    zoe.extend({obj: 'A'}, {another: 'prop'}, 'DEFINE');
  
    zoe.extend({obj: 'A'}, {obj: 'B'}, 'DEFINE');
    //throws the warning (check the console log) - zoe.extend: "obj" override error. ->No override specified. 
  ```
        """
      ,
        sectionName: 'zoe.extend.REPLACE'
        markdown: """
  ### Definition
    * Copies all properties from objB to objA, replacing them on objA regardless of whether they are already defined.
        """
      ,
        sectionName: 'zoe.extend.FILL'
        markdown: """
  ### Definition
  *'Fills in' any properties which aren't already defined.*
    
    * Copies properties from objB to objA, only when they are not already defined.
    
  #### Example
  ```jslive
    zoe.extend({obj: 'A'}, {obj: 'B', another: 'prop'}, 'FILL').obj;
  ```
        """
      ,
        sectionName: 'zoe.extend.DREPLACE'
        markdown: """
  _Performs a deep copy of the properties from objB onto objA._
  
    * Replaces all properties, except objects which get in turn extended based on replacement.
        """
      ,
        sectionName: 'zoe.extend.DFILL'
        markdown: """
  _Performs a **deep fill** of properties from objB onto objA._
  
  * Copies properties from objB to objA, when not already present.
  * When a property is an object on objA, in turn applies a deep fill extend to that object.
        """
      ,
        sectionName: 'zoe.extend.IGNORE'
        markdown: """
  _Ignores the property, acting as if the property was never present on the extending object._
  
  * Undefined properties remain undefined.
  * Defined properties remain in tact.
        """
      ,
        sectionName: 'zoe.extend.STR_APPEND'
        markdown: """
  _Appends string properties._
  
  * Assumes the property is a string or undefined.
        """
      ,
        sectionName: 'zoe.extend.STR_PREPEND'
        markdown: """
  _Appends string properties in reverse order._
        """
      ,
        sectionName: 'zoe.extend.ARR_APPEND'
        markdown: """
  _Concatenates arrays._
  
  * Assumes the property is an array or undefined.
        """
      ,
        sectionName: 'zoe.extend.ARR_PREPEND'
        markdown: """
  _Reverse concatenates arrays._
          
        """
      ,
        sectionName: 'zoe.extend.APPEND'
        markdown: """
  _Combination extension function. Used by the **__propertyName** extension notation._
  
  * Chain together functions with zoe.fn()
  * Extend objects with replacement
  * Append strings
  * Concatenate arrays
  * Replace any other property type
        """
      ,
        sectionName: 'zoe.extend.PREPEND'
        markdown: """
  _Reciprocal of zoe.extend.APPEND. Used by the **propertName__** extension notation._
  
  * Chain together functions as zoe.fn() chains, but first in the execution chain
  * Extend objects with the fill rule, replacing properties not already defined only
  * Prepend strings
  * Reverse concatenate arrays
  * 'Fill' any other property type (create it if not already defined)
        """
      ,
        sectionName: 'zoe.extend.DAPPEND'
        markdown: """
  _Applies an APPEND rule, but with depth on objects._
        """
      ,
        sectionName: 'zoe.extend.DPREPEND'
        markdown: """
  _Applies the PREPEND rule with depth._
        """
      ,
        sectionName: 'zoe.extend.CHAIN'
        markdown: """
  A natural way to extend functions is to convert them into instances of zoe.fn, if not
  already, and have the extending function added to the list of functions in the execution chain.
  
  _Appends the function from objB to a zoe.fn chain on objA._
  
  * If already a zoe.fn on the host object, simply ammends the function from objB to the list.
  * If not already a zoe.fn, creates a zoe.fn on the host object and adds any existing function on the host object to the chain.
  * Uses the default zoe.fn.LAST_DEFINED execution function.
  * Adds the new function to the chain with the 'on' method.
  
#### Example
   
  ```jslive
    var a = {
      sayHi: function() {
        alert('hi');
      },
    };
  
    zoe.extend(a, {
      __sayHi: function() {
        alert('hooked with zoe.fn!');
      },
    });
  
    a.sayHi();
  ```
  
  Note that the use of '__' extension notation applies the APPEND rule, which in turn calls the CHAIN rule for functions.
  
  So that the above is equivalent to using:
  
  ```javascript
    zoe.extend(a, b, {
      sayHi: 'CHAIN',
    });
  ```
        """
      ,
        sectionName: 'zoe.extend.CHAIN_FIRST'
        markdown: """
  _Adds the function from objB to the beginning of a zoe.fn chain on objA._
  
  It uses the 'first' instance method provided by zoe.fn.
        """
      ,
        sectionName: 'zoe.extend.CHAIN_STOP_DEFINED'
        markdown: """
  _Adds the function to a zoe.fn chain on objA, with the enforced execution function zoe.fn.STOP_DEFINED._
        """
      ,
        sectionName: 'zoe.extend.makeChain'
        markdown: """
  Any zoe.fn execution function can be converted into a zoe.extend chain extension function.
  
  For example, having zoe.fn.ASYNC step functions which can combine through extension.
  
  To convert any zoe.fn execution function into an extension rule, use makeChain.
  
  ### Usage
  
  ```javascript
    zoe.extend.makeChain(EXECUTION_FUNCTION, first)
  ```
  
  * **EXECUTION_FUNCTION, function**: _The zoe.fn execution function to use_
  * **first, boolean** (optional): _A boolean indicating whether the chain should use 'on' or 'first' to add a new item to the
     beginning or end of the function chain._
  
  #### Example

  zoe.extend.CHAIN is defined by:
  
  ```javascript
    zoe.extend.CHAIN = zoe.extend.makeChain(zoe.fn.LAST_DEFINED);
  ```
  
  #### Example
  
  Here is the example for creating an ASYNC function combination by extension:
  
  ```jslive
    var Load = {
      load: function(next) {
        setTimeout(next, 2000);
      }
    }
    var LoadExtra = {
      load: function(next) {
        setTimeout(next, 1000);
      }
    }
  
    zoe.extend(Load, LoadExtra, {
      load: zoe.extend.makeChain(zoe.fn.ASYNC)
    });
  
    Load.load(function() {
      //takes 3 seconds to execute
      alert('complete');
    });
  ```
  
  ***
        """
      ]
    ,
      chapterName: 'zoe.create'
      sections: [
        sectionName: 'zoe.create'
        markdown: """
  JavaScript object inheritance.
  
  _Creates a new instance of the class defined by **definition**, inheriting from the additional definitions, **[inherits]**._
  
  ### Usage:
  
  ```javascript
    zoe.create(inherits, definition);
  ```
  
  * **inherits, Array** (optional): _An array of inheritor definitions._
  * **definition, Object**: _The definition template object to create from._
          
  ### Mechanism:
          
  * `zoe.create` creates a new empty JavaScript object, and then extends that
    object with properties from each of the inheritors in turn, starting from the beginning of the **inherits** array to the end,
    and then finally extending by **definition**.
  * There are then 7 optional properties which can be used to further control and hook into the extension process.
  
    The most important of these is **_extend**, which would typically be used by most classes.
    
  * **_extend, Object** : _Specifies the extension rule map to use with `zoe.extend`._
    * By default, this _extend object is automatically overwritten with a REPLACE extension for successive _extend properties implemented.
    * In this way, a class can hold its own extensible property extension rules, which get added to the list as extension occurs.
    
  * The remaining properties are:
      * **_base, function**: _Allows for customising the initial object used for extension. This allows the output of zoe.create to be any type of object like a function or array._
        ```javascript
          function _base() {
            return baseObj;
          }
        ```
        * **baseObj**: Any object-based type to use as the initial object to extend by zoe.create.
        
        If not specified, a new empty JavaScript object is used.
        When multiple _base properties are provided, the lowest inheritor in the stack is used.
      
      * **_implement**: _An alternative way of specifying inherits. Identical to the **[inherits]** array._
      
      **_definition**: The full definition used to create the class is stored as obj._definition. This allows
        the ability to use the created class as a future inheritor. To allow for this, a `_definition` property
        is checked on each inheritor, and if it exists, that property is used as the inheritor instead.
      
      * **_reinherit**: _Rarely used. For multiple inheritance, the diamond problem is avoided by disabling reinheritance. This flag allows that to be overridden._
      
      * **_make**: _Allows each implementor to modify the base object functionally._
        ```javascript
          function _make(createDefinition, makeDefinition) {
            //performs operations on 'this' to do any class creation
          }
        ```
        * **createDefinition, Object**: _The main definition currently being used to build the class._
        * **makeDefinition, Object**: _The definition for the inheritor whose make function this is._
        * **this, Object**: _The object being created. To be modified by the make function._
      
      * **_integrate**: _Just like make, but applied for every single inheritance._
        ```javascript
          function _implement(makeDefinition, createDefinition) {
            //performs operations on 'this' to do any class modification
            return adjustedMakeDefinition;
          }
        ```
        * **makeDefinition, Object**: _The current definition being implemented onto the class._
        * **createDefinition, Object**: _The main definition being used to build the class._
        * **this, Object**: _Bound to the object being created._
        * **return value, Object** (optional): _In rare cases, it can be beneficial to provide a modified implementor definition, which is taken from the return value. The primary use case for this
          is to allow standard JavaScript constructors as inheritance items when implementing zoe.Constructor._
      
      * **_built**: _The final hook - called after running extension from every implementor._
        ```javascript
          function _built(createDefinition) {
            //perform any final adjustments
          }
        ```
        * **createDefinition, Object**: _The main definition object being used to create the class._
        * **this, Object**: _The class object being created._
    
  
    * **Note:** For the _integrate, _make and _built functions, these should never modify the definition objects,
      only the output object.
       
      This is because definition objects are designed to be immutable, and should be able to be
      implemented with the same results at any later points.

      The only modification made by zoe.create is automatically appending the _implement array of the primary
      definition when the inheritor form of zoe.create is used - `zoe.create([inheritors], definition);`
    """
      ,
        sectionName: 'zoe.create - Examples'
        markdown: """
  
  The details cover a wide range of eventualities and may seem quite complex, but the basic usage remains simple. Here
  are some examples to demonstrate.
  
  #### Basic Creation
  
    ```jslive
      var myClass = zoe.create({hello: 'world'});
      myClass.hello;
    ```
    
  #### Basic Extension
    ```jslive
      var baseClass = {
        hello: 'world'
      };
      
      var derivedClass = zoe.create([baseClass], {
        another: 'property'
      });
      
      derivedClass.hello;
    ```
    
  #### Extension with Extension Rules
    ```jslive
      var greetClass = {
        _extend: {
          greet: 'CHAIN'
        },
        greet: function() {
          return 'hi';
        }
      };
      
      var myClass = zoe.create([greetClass], {
        greet: function() {
          alert('greeting');
        }
      });
      
      myClass.greet();
    ```
    
    Here we use function chaining as the extension rule, which gets passed into `zoe.extend`, causing the greet method to be built out
    of both functions.
  
  
        """
      ,
        sectionName: 'zoe.inherits'
        markdown: """
  _A utility function to determine if an object has inherited the provided definition._
  
  ### Usage:
    ```javascript
      zoe.inherits(obj, def);
    ```
    * **obj**: _The object to check inheritance._
    * **def**: _The definition to see if it inherits from._
    * **return value**: _True or false._
        """
      ,
        sectionName: 'zoe.Constructor'
        markdown: """
        
  _A base implementor to enable prototypal inheritance with `zoe.create`._
  
  ### Usage
  ```javascript
    var myConstructor = zoe.create([zoe.Constructor], {
      construct: function(arg1, arg2, ...) {
      },
      prototype: {
        prooperty: value
      }
    });
  
    var p = new myConstructor(arg1, arg2, ...);
  ```
  
  * When implemented, or implementing any other class that implements zoe.Constructor, a function is returned which runs the construct object
    when instantiated.
  * The prototype object property becomes prototype of the new object, as with standard JavaScript inheritance.
  * By default, the construct function gets extended by chaining (zoe.Constructor provides this as an _extend rule).
  * By default, the prototype object gets extended.
  * Additionally, standard JavaScript classes written natively can also be included as implementors.
  
  #### Example
  
  For example, an init event / chain:
  ```jslive
    var initBase = {
      _implement: [zoe.Constructor],
      _extend: {
        'prototype.init': zoe.extend.CHAIN
      },
      construct: function() {
        this.init();
      },
      prototype: {
        init: function() {
          console.log('init function');
        }
      }
    };
    
    var myClass = zoe.create([initBase], {
      prototype: {
        alertMsg: function(msg) {
          alert(msg);
        },
        init: function() {
          this.alertMsg('init msg');
        }
      }
    });
    
    var classInstance = new myClass();
    classInstance.alertMsg('custom message');
  ```
  
  This Constructor model is the inheritance model used for Zest components.
        """
      ]
    ]
    