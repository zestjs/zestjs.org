define(['zest', 'css!./button'], function($z) {
  return {
    className: 'MyButton',
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
    attach: './button6-attach'
  };
});