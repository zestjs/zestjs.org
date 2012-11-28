define(['zest', 'css!./button'], function($z) {
  return {
    type: 'MyButton',
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
    attach: function(o, els) {
      els[0].addEventListener('click', function() {
        alert(o.msg);
      });
    }
  };
});