define(['css!./button'], function() {
  return {
    className: 'MyButton',
    render: function(o) {
      return '<button>' + o.text + '</button>';
    }
  };
});