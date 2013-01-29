define(['zest', 'css!./button'], function($z) {
  return {
    'class': 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: function(el, o) {
      el.addEventListener('click', function() {
        alert('click');
      });
    }
  };
});