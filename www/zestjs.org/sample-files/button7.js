define(['zest', 'css!./button'], function($z) {
  return {
    className: 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: './button7-controller'
  };
});