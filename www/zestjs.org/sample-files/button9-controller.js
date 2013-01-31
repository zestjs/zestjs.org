define(['zest', 'jquery'], function($z, $) {
  return function(el, o) {
    var clickEvent = $z.fn();
    $(el).click(clickEvent);
    
    return {
      click: clickEvent,
      dispose: function() {
        el.removeEventListener('click', clickEvent);
      }
    };
  }
});