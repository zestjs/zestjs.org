define(['zest', 'jquery'], function($z) {
  return $z.create([$z.Constructor, $z.InstanceEvents], {
    _events: ['click'],
    construct: function(el, o) {
      this.$button = $(el);

      // click event already created on the instance and bound to the controller, 
      // including the base click event.
      this.$button.click(this.click);
    },
    prototype: {
      // base click function for all instances (optional)
      click: function() {
        alert('base click event');
      },
      dispose: function() {
        this.$button.unbind();
      }
    }
  });
});