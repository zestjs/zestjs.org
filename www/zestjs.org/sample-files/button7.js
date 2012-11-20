define(['zest', 'css!./button'], function($z) {
  return {
    type: 'BigButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: function(o, els) {
      var _clickCallback = function(){};
      var controller = {
        setClickCallback: function(callback) {
          _clickCallback = callback;
        }
      };
      els[0].addEventListener('click', function() {
        _clickCallback();
      });
      return controller;
    }
  };
});