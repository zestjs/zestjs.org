define ['zest', 'app/button9', 'css!./dialog'], ($z, Button) ->
  $z.create([$z.Component],
    type: 'SimpleDialog'
    options:
      closeButton: false
    template: (o) -> """
      <div>
        {`content`}
        <div class='footer'>{`footer`}</div>
      </div>
    """
    footer: (o) ->
      if !o.closeButton
        null
      else
        structure: Button
        options:
          text: 'Close'
    
    pipe: (o) ->
      closeButton: o.closeButton
      
    construct: (o) ->
      if o.closeButton
        @$z('BigButton').click.on @close
    prototype:
      __close: ->
        @dispose();
  )