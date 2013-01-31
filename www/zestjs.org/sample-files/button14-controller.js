define(['jquery'], function($) {
  return $z.create([$z.Component], {
    _events: ['click'],
    construct: function(el, o) {
      this.$button = $(el);
      this.$button.click(this.click);
    },
    prototype: {
      click: function() {
        alert('a prototype event function');
      },
      dispose: function() {
        this.$button.unbind();
      }
    }
  });
});