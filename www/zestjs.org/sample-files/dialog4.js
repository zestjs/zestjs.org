define(['app/button8', 'css!./dialog'], function(Button) {
  return {
    type: 'SimpleDialog',
    options: {
      closeButton: false
    },
    template: function(o) {
      return "<div>{`content`}<div class='footer'>{`footer`}</div></div>"
    },
    footer: function(o) {
      if (!o.closeButton)
        return null;
      else
        return {
          structure: Button,
          options: {
            text: 'Close'
          }
        };
    },
    pipe: function(o) {
      return {
        closeButton: o.closeButton
      };
    },
    attach: function($$, o) {
      if (o.closeButton)
        $z('BigButton', $$).setClickCallback(function() {
          $z.dispose($$);
        });
    }
  };
});