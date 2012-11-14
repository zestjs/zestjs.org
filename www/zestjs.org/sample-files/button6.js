define(['zest', 'css!./button'], function($z) {
  return {
    type: 'BigButton',
    options: {
      text: 'Button',
      msg: 'Message'
    },
    template: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    pipe: function(o) {
      return {
        msg: o.msg
      };
    },
    attach: function(els, o) {
      els[0].addEventListener('click', function() {
        alert(o.msg);
      });
    }
  };
});