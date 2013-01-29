define(['zest', 'jquery', 'css!./button'], function($z, $) {
  return $z.create([$z.Constructor], {
    'class': 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    attach: function(el, o) {
      return new this(el, o);
    },
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