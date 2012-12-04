define(['zest', 'jquery', 'css!./button'], function($z, $) {
  // attachment
  function ButtonComponent(el, o) {
    this.$button = $(el);
    this.click = $z.fn();

    this.$button.click(this.click);
  }
  ButtonComponent.prototype.dispose = function() {
    this.$button.unbind();
  }

  // rendering
  ButtonComponent.attach = function(el, o) {
    return new this(el, o);
  }
  ButtonComponent.type = 'MyButton';
  ButtonComponent.options = {
    text: 'Button'
  };
  ButtonComponent.render = function(o) {
    return '<button>' + $z.esc(o.text, 'htmlText') + '</button>';
  }

  return ButtonComponent;
});