define(['zest', 'css!./button'], function($z) {
  return {
    type: 'BigButton',
    options: {
      text: 'Button'
    },
    template: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: function(els) {
      els[0].addEventListener('click', function() {
        alert('click');
      });
    }
  };
});