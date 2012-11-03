define ['zest'], ($z) ->
  options:
    top: 'black';
    bottom: 'black';

  template: "<hr/>"
  css: (o) -> """
    ##{o.id} {
      border: none;
      border-top: 1px solid #{$z.esc(o.top, 'cssAttr')};
      border-bottom: 1px solid #{$z.esc(o.bottom, 'cssAttr')};
    }
  """
  
