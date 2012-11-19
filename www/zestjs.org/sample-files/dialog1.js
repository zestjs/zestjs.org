define(['css!./dialog'], function() {
  return {
    type: 'SimpleDialog',
    render: function(o) {
      return "<div>{`content`}</div>"
    }
  };
});