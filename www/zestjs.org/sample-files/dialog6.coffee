define ['zest', 'cs!app/button', 'css!./dialog'], ($z, Button) ->
  className: 'SimpleDialog'
  options:
    width: 400
    height: 300
  render: (o) -> """
    <div>
      {`content`}
      <div class='button'>{`button`}</div>
    </div>
  """

  style: (o) -> """
    ##{o.id} {
      width: #{$z.esc(o.width, 'num', @options.width)}px;
      height: #{$z.esc(o.height, 'num', @options.height)}px;
    }
  """

  button: (o) ->
    render: Button
    options:
      text: o.confirmText

  attach: 'cs!./dialog5-attach'