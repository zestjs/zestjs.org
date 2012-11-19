define [
  'zest'
  'cs!../page/page'

  'cs!./sidebar'
  'cs!./contents'
  'cs!./documentation'
], ($z, Page, Sidebar, Contents, Docs) ->
  $z.create([Page],
    options:
      title: 'Documentation'
      data: []
      section: 'docs'

    content: (o) ->
      render: Sidebar
      options:
        title: o.title
        
        sidebar:
          render: Contents
          options:
            contents: o.data
        
        content:
          render: Docs
          options:
            contents: o.data
  )
