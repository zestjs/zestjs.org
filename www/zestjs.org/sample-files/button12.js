define(['zest', 'jquery', 'css!./button'], function($z, $) {
  return $z.create([$z.Component], {
    'class': 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    construct: function(el, o) {
      this.$button = $(el);
      this.$button.click(this.click);
    },
    prototype: {
      __click: function() {
        alert('a prototype event function');
      },
      dispose: function() {
        this.$button.unbind();
      }
    }
  });
});