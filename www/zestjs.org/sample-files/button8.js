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
      var clickEvent = function() {
        _clickCallback();
      }
      
      els[0].addEventListener('click', clickEvent);
      return {
        setClickCallback: function(callback) {
          _clickCallback = callback;
        },
        dispose: function() {
          els[0].removeEventListener('click', clickEvent)
        }
      };
    }
  };
});