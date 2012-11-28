define(['zest', 'css!./button'], function($z) {
  return $z.create([$z.Component], {
    type: 'MyButton',
    options: {
      text: 'Button'
    },
    render: function(o) {
      return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
    },
    construct: function(o) {
      this.$('button')[0].addEventListener('click', this.click);
    },
    prototype: {
      __click: function() {},
      dispose: function() {
        this.$('button')[0].removeEventListener('click', this.click);
      }
    }
  });
});