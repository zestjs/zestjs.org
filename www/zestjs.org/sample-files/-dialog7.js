define(['app/dialog5'], function(Dialog) {
  return $z.create([Dialog], {
    prototype: {
      newMethod: function() {
        alert('new instance method');
      },
      __close: function() {
        alert('new dialog closed!');
      }
    }
  });
});