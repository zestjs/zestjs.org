define(['app/button6', 'css!./dialog'], function(Button) {
  return {
    type: 'SimpleDialog',
    render: function(o) {
      return "<div>{`content`}<div class='footer'>{`footer`}</div></div>"
    },
    footer: {
      render: Button,
      options: {
        text: 'Dialog button',
        msg: 'Dialog message'
      }
    }
  };
});