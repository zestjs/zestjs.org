define(['app/button6', 'css!./dialog'], function(Button) {
  return {
    type: 'SimpleDialog',
    template: function(o) {
      return "<div>{`content`}<div class='footer'>{`footer`}</div></div>"
    },
    footer: {
      structure: Button,
      options: {
        text: 'Dialog button',
        msg: 'Dialog message'
      }
    }
  };
});