define(['zest', './button11'], function($z, Button) {
  return $z.create([Button], {
    _extend: {
      'attach': 'REPLACE'
    },
    pipe: ['text'],
    attach: './button12-controller'
  });
});