define(['zest', 'css!./button'], function($z) {
  return {
    'class': 'MyButton',
    options: {
      text: 'Button',
      msg: 'Message'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    pipe: function(o) {
      return {
        msg: o.msg
      };
    },
    attach: function(el, o) {
      el.addEventListener('click', function() {
        alert(o.msg);
      });
    }
  };
});