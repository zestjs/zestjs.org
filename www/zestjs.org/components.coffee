define ['cs!./page/page'], (Page) ->
  render: Page
  options:
    title: 'Component Library'
    section: ''
    content: ['<h1>Coming Soon</h1>']


  ###
      ,
        chapterName: 'Zest Component Event and Inheritance Model'
        sections: [
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
            type: 'MyButton',
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
                this.$z('MyButton').click.on(this.close);
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
        var buttonInstance = $z('MyButton', document.querySelector('.container-13'));
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
        ]
      ,
  ###