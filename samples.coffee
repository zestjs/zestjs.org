define ['cs!app/dialog1'], (Dialog) ->
  routes:
    '/dialog1': 
      title: 'Dialog Page'
      body: '@cs!app/dialog2'

    '/dialog2/{width}/{height}': 
      title: 'Dialog Page'
      body: '@cs!app/dialog2'

    '/dialog3':
      title: 'Dialog Page'
      requireMain: 'test'
      body: '@cs!app/dialog2'
      options:
        width: 400
        height: 50
        confirmText: 'Ok'
      load: (o) ->
        o.content = '<p>The time is ' + (new Date()).toLocaleTimeString() + '</p>'

    '/dialog4':
      title: 'Dialog Page'
      structure:
        render: Dialog
        options:
          closeButton: true
          content: ['<p>dialog</p>']
          width: 400
          height: 100
      
