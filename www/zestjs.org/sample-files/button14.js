define(['zest', 'css!./button'], function($z) {
  return $z.create([$z.Component], {
    className: 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: './button14-controller'
  });
});