define(['css!./button'], function() {
  return {
    'class': 'MyButton',
    render: function(o) {
      return '<button>' + o.text + '</button>';
    }
  };
});