define ['cs!../com/line-break', 'css!./sidebar'], (LineBreak) ->
  options:
    content: ''
    sidebar: ''
  
  template: '''
    <div class="sidebar">{`sidebar`}</div>
    <div class="content">{`content`}</div>
  '''
  
  sidebar: (o) -> [
    "<h1 class='page-title'>#{o.title}</h1>"
  ,
    structure: LineBreak
    options:
      top: '#d9d9d9'
      bottom: '#ffffff'
  ,
    o.sidebar
  ]
