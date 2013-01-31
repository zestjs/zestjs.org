define([], function() {
  return function(el, o) {
    el.addEventListener('click', function() {
      alert('click');
    });
  };
});