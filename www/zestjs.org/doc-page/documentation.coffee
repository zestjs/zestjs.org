define ['is!render?marked', 'is!browser?jquery', 'less!./documentation'], (marked, $) ->
  marked.setOptions
    gfm: true
    highlight: (code, lang) ->
      if lang == 'javascript'
        code
          .replace(/\/\/(.*)/gm, '<span class="comment">//$1</span>')
          .replace(/('.*')/gm, '<span class="string">$1</span>')
          .replace(/\d+/gm, '<span class="number">$1</span>')
          .replace(/\b(for|function|new|throw|return|var|if|else)\b/gm, '<span class="keyword">$1</span>')
      else if lang == 'coffeescript'
        code
          .replace(/#(.*)/gm, '<span class="comment">#$1</span>')
          .replace(/(".*")/gm, '<span class="string">$1</span>')
          .replace(/(\d+)/gm, '<span class="number">$1</span>')
          .replace(/\b(function|new|throw|return|var|if|else)\b/gm, '<span class="keyword">$1</span>')
      else
        code
    
  options:
    # example documentation data object:
    contents: [
      chapterName: 'This is a chapter'
      sections: [
        sectionName: 'This is a section'
        markdown: '#Documentation markdown'
      ]
    ]
  # run rendering from documentation to HTML
  template: (o) ->
    __ = "<div class='documentation'>"
    for content in o.contents
      __ += "<a name='#{content.chapterName}' href='##{content.chapterName}'></a><h1>#{content.chapterName}</h1>"
      for section in content.sections
        __ += "<a name='#{section.sectionName}' href='##{section.sectionName}'></a><h2>#{section.sectionName}</h2>"
        __ += marked section.markdown
      __ += "<div class='spacing'></div>"
    __ += "</div>"
    __
  
  attach: ($$, o) ->
    $('a', $$).each ->
      $(@).attr 'target', '_blank' if $(@).attr('href').substr(0, 1) != '#'