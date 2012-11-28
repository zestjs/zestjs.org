define(['css!./button'], function() {
  return {
    type: 'MyButton',
    render: function(o) {
      return '<button>' + o.text + '</button>';
    }
  };
});