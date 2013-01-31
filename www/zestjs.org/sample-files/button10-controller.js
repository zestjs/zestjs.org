define(['zest', 'jquery'], function($z, $) {
  return $z.create([$z.Constructor], {
    construct: function(el, o) {
      this.$button = $(el);
      this.click = $z.fn();

      this.$button.click(this.click);
    },
    prototype: {
      dispose: function() {
        this.$button.unbind();
      }
    }
  });
});