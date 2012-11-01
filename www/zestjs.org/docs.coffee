define [
  'cs!./com/page'
  'cs!./com/sidebar'
  
  'cs!./docs/contents'
  'cs!./docs/documentation'
  
  'cs!./data/docs.json'
], (Page, Sidebar, Contents, Docs, docData) ->
  $z.create([Page],
    options:
      section: 'docs'

    load: (o) ->
      o.global.setTitle('Documentation')
      
    content:
      structure: Sidebar
      options:
        title: 'Docs / Tutorial'
        
        sidebar:
          structure: Contents
          options:
            contents: docData
        
        content:
          structure: Docs
          options:
            contents: docData    
  )
