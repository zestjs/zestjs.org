define(['app/button6', 'css!./dialog'], function(Button) {
  return {
    className: 'SimpleDialog',
    render: "<div>{`content`}<div class='button'>{`button`}</div></div>",
    button: Button
  };
});