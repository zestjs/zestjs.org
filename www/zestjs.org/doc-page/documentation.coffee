define ['marked', 'is!browser?jquery', 'zoe', 'less!./documentation'], (marked, $, zoe) ->
  marked.setOptions
    gfm: true
    highlight: (code, lang) ->
      if lang == 'javascript' || lang == 'jslive'
        code
          .replace(/\/\/(.*)/gm, '<span class="comment">//$1</span>')
          .replace(/('[^']*')/gm, '<span class="string">$1</span>')
          .replace(/([^#\d])(\d+)/gm, '$1<span class="number">$2</span>')
          .replace(/\b(for|function|new|throw|return|var|if|else|true|false|this)\b/gm, '<span class="keyword">$1</span>')
      else if lang == 'coffeescript' || lang == 'cslive'
        code
          .replace(/[^&]#([^{].*)/gm, '$1<span class="comment">#$2</span>')
          .replace(/("[^"]*")/gm, '<span class="string">$1</span>')
          .replace(/('[^']*')/gm, '<span class="string">$1</span>')
          .replace(/([^#\d])(\d+)/gm, '$1<span class="number">$2</span>')
          .replace(/(\-\>|new|throw|return|if|else|true|false|this|@)/g, '<span class="keyword">$1</span>')
      else if lang == 'css' || lang == 'less'
        code
          .replace(/("[^"]*")/gm, '<span class="string">$1</span>')
          .replace(/([\w-]+):/gm, '<span class="property">$1</span>:')
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
  render: (o) ->
    __ = "<div class='documentation'>"
    for content in o.contents
      __ += "<a name='#{content.chapterName}' href='##{content.chapterName}'></a><h1>#{content.chapterName}</h1>"
      for section in content.sections
        __ += "<a name='#{section.sectionName}' href='##{section.sectionName}'></a><h2>#{section.sectionName}</h2>"
        __ += marked section.markdown
      __ += "<div class='spacing'></div>"
    __ += "</div>"
    __
  
  attach: 'cs!./documentation.controller'
  progressive: true