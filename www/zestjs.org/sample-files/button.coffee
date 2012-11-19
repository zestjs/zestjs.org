define ['zest', 'css!./button'], ($z) ->
  $z.create([$z.Component],
    type: 'BigButton'
    options:
      text: 'Button'
    render: (o) -> "<button>#{$z.esc(o.text, 'htmlText')}</button>"
    construct: (o) ->
      @$('button')[0].addEventListener 'click', @click
    prototype:
      __click: ->
      dispose: ->
        @$('button')[0].removeEventListener 'click', @click
  )