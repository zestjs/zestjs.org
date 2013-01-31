define [], () ->
  return (el, o) ->
    MyButton = $z.select '>.button MyButton', el
    MyButton.click.on -> $z.dispose el
    return null # no controller
