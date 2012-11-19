define(['app/button6', 'css!./dialog'], function(Button) {
  return {
    type: 'SimpleDialog',
    options: {
      closeButton: false
    },
    render: function(o) {
      return "<div>{`content`}<div class='footer'>{`footer`}</div></div>"
    },
    footer: function(o) {
      if (!o.closeButton)
        return null;
      else
        return {
          render: Button,
          options: {
            text: 'Close'
          }
        };
    }
  };
});