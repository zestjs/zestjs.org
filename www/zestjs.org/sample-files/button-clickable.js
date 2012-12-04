define(['zest', './button-unclickable'], function($z, Button) {
  return $z.create([Button], {
    prototype: {
      __hide__: function() {
        this.$button.stop().animate({ opacity: 0.5 }, 50);
        this._visible = false;
      }
    }
  });
});