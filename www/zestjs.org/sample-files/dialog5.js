define(['zest', 'app/button9', 'css!./dialog'], function($z, Button) {
  return $z.create([$z.Component], {
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
    construct: function(o) {
      if (o.closeButton)
        this.$z('BigButton').click.on(this.close);
    },
    prototype: {
      __close: function() {
        this.dispose();
      }
    }
  });
});