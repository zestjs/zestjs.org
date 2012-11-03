define [
  'cs!./page/page'
], (Page) ->
  $z.create([Page],
    options:
      title: 'ZestJS'
      section: ''
    content: ['Welcome']
  )
