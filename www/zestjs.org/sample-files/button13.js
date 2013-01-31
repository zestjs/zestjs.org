define(['zest', './button12'], function($z, ButtonHover) {
  return $z.create([ButtonHover], {
    _extend: {
      options: 'EXTEND',
      pipe: 'ARR_APPEND'
    },
    options: {
      doHover: true
    },
    pipe: ['doHover'],
    attach: './button13-controller'
  });
});