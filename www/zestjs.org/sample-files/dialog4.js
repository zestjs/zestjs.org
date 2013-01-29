define(['app/button8', 'css!./dialog'], function(Button) {
  return {
    'class': 'SimpleDialog',
    render: "<div>{`content`}<div class='button'>{`button`}</div></div>",
    button: function(o) {
      return {
        render: Button,
        options: {
          text: o.confirmText
        }
      };
    },
    attach: function(el, o) {
      var Button = $z.select('>.button .MyButton', el);
      Button.click.on(function() {
        $z.dispose(el);
      });
    }
  };
});