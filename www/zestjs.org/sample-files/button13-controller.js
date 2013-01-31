define(['./button12-controller'], function(ButtonHoverController) {
  return $z.create([ButtonHoverController], {
    _extend: {
      'prototype.hoverIn': 'REPLACE'
    },
    construct: function(el, o) {
      this.doHover = o.doHover;
    },
    prototype: {
      hoverIn: function() {
        if (this.doHover)
          this.$button.text('Hovering!');
      }
    }
  });
});