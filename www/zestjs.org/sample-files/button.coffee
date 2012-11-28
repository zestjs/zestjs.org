define ['zest', 'is!browser?jquery', 'css!./button'], ($z, $) ->
  type: 'MyButton'
  options:
    text: 'Button'
  render: (o) -> "<button>#{$z.esc(o.text, 'htmlText')}</button>"
    
  attach: (o, els) ->
    _clickCallback = ->
    $(els).click ->
      _clickCallback()

    setClickCallback: (callback) ->
      _clickCallback = callback
    dispose: ->
      $(els).unbind()