define ['cs!app/button', 'css!./dialog'], (Button) ->
  'class': 'SimpleDialog'
  render: """
    <div>
      {`content`}
      <div class='button'>{`button`}</div>
    </div>
  """

  button: (o) ->
    render: Button
    options:
      text: o.confirmText

  attach: (el, o) ->
    MyButton = $z.select '>.button .MyButton', el
    MyButton.click.on -> 
      $z.dispose el