define(['css!./button'], function() {
  return {
    type: 'BigButton',
    template: function(o) {
      return '<button>' + o.text + '</button>';
    }
  };
});