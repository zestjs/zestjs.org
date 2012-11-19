define(['css!./button'], function() {
  return {
    type: 'BigButton',
    render: function(o) {
      return '<button>' + o.text + '</button>';
    }
  };
});