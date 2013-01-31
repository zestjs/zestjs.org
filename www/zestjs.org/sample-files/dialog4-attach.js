define(['zest'], function($z) {
  return function(el, o) {
    var MyButton = $z.select('>.button .MyButton', el);
    MyButton.click.on(function() {
      $z.dispose(el);
    });
  }
});