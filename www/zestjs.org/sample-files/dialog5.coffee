define ['cs!./button', 'css!./dialog'], (Button) ->
  className: 'SimpleDialog'
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

  attach: 'cs!./dialog5-attach'