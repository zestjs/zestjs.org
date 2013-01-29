define ['zest', 'jquery', 'css!./button'], ($z, $) ->
  'class': 'MyButton'
  options:
    text: 'Button'
  render: (o) -> "<button>#{$z.esc(o.text, 'htmlText')}</button>"
    
  attach: (el, o) ->
    clickEvent = $z.fn()
    $(el).click clickEvent

    click: clickEvent
    dispose: -> 
      $(el).unbind()