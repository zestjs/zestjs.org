define(['css!./dialog'], function() {
  return {
    type: 'SimpleDialog',
    template: function(o) {
      return "<div>{`content`}</div>"
    }
  };
});