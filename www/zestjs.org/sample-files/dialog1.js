define(['css!./dialog'], function() {
  return {
    'class': 'SimpleDialog',
    render: function(o) {
      return "<div>{`content`}</div>"
    }
  };
});