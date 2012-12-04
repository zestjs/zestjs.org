define(['zest', 'css!./button'], function($z) {
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
      el.addEventListener('click', clickEvent);
      
      return {
        click: clickEvent
      };
    }
  };
});