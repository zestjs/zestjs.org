define ['is!~browser?markdown', 'less!./documentation'], (markdown) ->
  ###
  options:
    contents: [
      chapterName: 'This is a chapter'
      sections: [
        sectionName: 'This is a section'
      ]
    ]
  ###
  template: (o) ->
    # run rendering from documentation to HTML
    tpl = '<div class="documentation">'
    if (markdown.markdown)
      Markdown = markdown.markdown
    else
      Markdown =
        toHTML: (html) -> html
    for content in o.contents
      tpl += '<h1>' + content.chapterName + '</h1>'
      for section in content.sections
        tpl += '<h2>' + section.sectionName + '</h2>'
        tpl += Markdown.toHTML section.markdown
      tpl += '<div class="spacing"></div>'
    return tpl + "</div>";
