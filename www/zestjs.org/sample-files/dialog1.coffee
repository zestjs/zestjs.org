define ['zest', 'cs!app/button', 'css!./dialog'], ($z, Button) ->
  type: 'SimpleDialog'
  options:
    closeButton: false
  render: (o) -> """
    <div>
      {`content`}
      <div class='footer'>{`footer`}</div>
    </div>
  """
  footer: (o) ->
    if !o.closeButton
      null
    else
      render: Button
      options:
        text: 'Close'
  
  pipe: (o) ->
    closeButton: o.closeButton
    
  attach: (o, els) ->
    if o.closeButton
      $z('MyButton', els).setClickCallback ->
        $z.dispose els