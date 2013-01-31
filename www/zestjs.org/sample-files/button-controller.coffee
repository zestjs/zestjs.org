define ['zest', 'jquery', 'css!./button'], ($z, $) ->
  return (el, o) ->
    clickEvent = $z.fn()
    $(el).click clickEvent

    return {
      click: clickEvent
      dispose: -> 
        $(el).unbind()
    }