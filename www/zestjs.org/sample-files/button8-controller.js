define(['zest'], function($z) {
  return function(el, o) {
    var clickEvent = $z.fn();
    el.addEventListener('click', clickEvent);
    
    return {
      click: clickEvent,
      dispose: function() {
        el.removeEventListener('click', clickEvent);
      }
    };
  }
});