define(['zest', './button11-controller'], function($z, ButtonController) {
  return $z.create([ButtonController], {
    _events: ['hoverIn', 'hoverOut'],
    construct: function(el, o) {
      this.text = o.text;
      this.$button.bind('mouseenter', this.hoverIn);
      this.$button.bind('mouseleave', this.hoverOut);
    },
    prototype: {
      hoverIn: function() {
        this.$button.text('Hovering!');
      },
      hoverOut: function() {
        this.$button.text(this.text);
      }
    }
  });
});