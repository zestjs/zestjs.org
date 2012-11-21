define ['zoe', 'jquery'], (zoe, $) ->
  (o, $$) ->
    if typeof window != 'undefined'
      window.zoe = zoe;
    
    $('a', $$).each ->
      $(@).attr 'target', '_blank' if $(@).attr('href').substr(0, 1) != '#'
      
    # live code examples
    $('code.lang-jslive', $$).each ->
      runButton = $ '<div class="run-code"><a class="run-button">Run</a><span class="result"></span></div>'
      $('.run-button', runButton).click ->
        parent = $(@).parent()
        try
          $('.result', parent).text eval $(@).parent().prev().text()
        catch e
          $('.result', parent).text 'Error: ' + e.toString()
      $(@).attr('contenteditable', true).attr('spellcheck', false).parent().after(runButton)