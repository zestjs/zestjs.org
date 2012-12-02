define [
  'cs!../page/page'

  'cs!./sidebar'
  'cs!./contents'
  'cs!./documentation'
], (Page, Sidebar, Contents, Docs) ->
  render: Page
  options:
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
