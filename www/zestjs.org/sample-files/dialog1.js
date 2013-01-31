define(['css!./dialog'], function() {
  return {
    className: 'SimpleDialog',
    render: function(o) {
      return "<div>{`content`}</div>"
    }
  };
});