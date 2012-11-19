define [
  'zest'
  'cs!./page/page'
], ($z, Page) ->
  $z.create([Page],
    options:
      title: 'ZestJS'
      section: ''
    content: ['Welcome']
  )
