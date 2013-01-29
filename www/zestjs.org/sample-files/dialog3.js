define(['app/button6', 'css!./dialog'], function(Button) {
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
    }
  };
});