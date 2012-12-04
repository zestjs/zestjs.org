define(['app/button9', 'css!./dialog'], function(Button) {
  return {
    type: 'SimpleDialog',
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
      var MyButton = $z.select('>.button MyButton', el);
      MyButton.click.on(function() {
        $z.dispose(el);
      });
    }
  };
});