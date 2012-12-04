define ['cs!../page/line-break', 'less!./contents'], (LineBreak) ->
  type: 'Contents'
  options:
    contents: [
      chapterName: 'This is a chapter'
      sections: [
        sectionName: 'This is a section'
      ]
    ]
  render: (o) ->
    contents = ""
    first = true
    for chapter in o.contents
      contents += "<h1><a #{if first then "class='active' " else ""}href='##{chapter.chapterName}'>#{chapter.chapterName}</a></h1>"
      for section in chapter.sections
        contents += "<h2><a #{if first then "class='active' " else ""}href='##{section.sectionName}'>#{section.sectionName}</a></h2>"
        first = false
    
    """
      <div>
        <div class="contents">
          #{contents}
        </div>
        <div class='contents-footer'>
          {`contentsFooter`}
        </div>
      </div>
    """
  
  contentsFooter: [
    render: LineBreak
    options:
      top: '#d9d9d9'
      bottom: '#ffffff'
  ,
    render: """
      <a class='github' href='https://github.com/zestjs' target='_blank'>Github</a>
      <a class='built-zest' href='https://github.com/zestjs/zestjs.org' target='_blank'>Built with ZestJS</a>
    """
  ]
    
  attach: 'cs!./contents.controller'
