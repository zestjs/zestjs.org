define(['zest', 'jquery', 'css!./button'], function($z, $) {
  return {
    type: 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
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