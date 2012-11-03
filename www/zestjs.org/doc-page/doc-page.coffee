define [
  'cs!../page/page'

  'cs!./sidebar'
  'cs!./contents'
  'cs!./documentation'
], (Page, Sidebar, Contents, Docs) ->
  $z.create([Page],
    options:
      title: 'Documentation'
      data: []
      section: 'docs'

    content: (o) ->
      structure: Sidebar
      options:
        title: o.title
        
        sidebar:
          structure: Contents
          options:
            contents: o.data
        
        content:
          structure: Docs
          options:
            contents: o.data
  )
