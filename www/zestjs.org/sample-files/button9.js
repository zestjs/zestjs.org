define(['zest', 'is!browser?jquery', 'css!./button'], function($z, $) {
  return {
    type: 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: function(o, els) {
      var _clickCallback = function(){};
      $(els).click(function() {
        _clickCallback();
      });
      return {
        setClickCallback: function(callback) {
          _clickCallback = callback;
        },
        dispose: function() {
          $(els).unbind();
        }
      };
    }
  };
});