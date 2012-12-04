define(['zest', './button11'], function($z, Button) {
  return $z.create([Button], {
    construct: function(el, o) {
      this._visible = true;
      var self = this;

      this.toggle = $z.fn([this.toggle]).bind(this);

      this.$button.mouseenter(this.toggle);
      this.$button.mouseleave(this.toggle);
    },
    prototype: {
      toggle: function() {
        if (this._visible)
          this.hide();
        else
          this.show();
      },
      hide: function() {
        this.$button.stop().animate({ opacity: 0 }, 50);
        this._visible = false;
      },
      show: function() {
        this.$button.stop().animate({ opacity: 1}, 50);
        this._visible = true;
      }
    }
  });
});