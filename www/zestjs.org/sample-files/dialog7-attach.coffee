define [], () ->
  return (el, o) ->
    MyButton = $z.select '>.button .MyButton', el
    MyButton.click.on -> $z.dispose el

    alert('height outside DOM: ' + el.offsetHeight)
    return {
      init: ->
        alert('height in DOM: ' + el.offsetHeight)
    }
