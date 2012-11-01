define [
  'cs!./page'
  'cs!../com/contents'
  'cs!../com/documentation'
  'cs!../com/line-break'
  
  'cs!../data/docs.json'

  'css!./docs'
], (Page, Contents, Docs, LineBreak, docData) ->
  $z.create([Page],
    options:
      section: 'docs'
      
    content:
      type: 'Documentation'
      template: '''
        <div class="sidebar">{`sidebar`}</div>
        <div class="content">{`content`}</div>
      '''
      sidebar: [
        '<h1 class="page-title">Docs / Tutorial</h1>'
      ,
        structure: LineBreak
        options:
          top: '#d9d9d9'
          bottom: '#ffffff'
      ,
        structure: Contents
        options:
          contents: docData
      ]
      content:
        structure: Docs
        options:
          contents: docData    
  )
