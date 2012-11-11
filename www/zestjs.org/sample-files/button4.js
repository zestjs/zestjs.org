define(['zest', 'css!./button'], function($z) {
  return {
    type: 'BigButton',
    options: {
      text: 'Button'
    },
    template: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    }
  };
});