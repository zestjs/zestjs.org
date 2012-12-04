define ['cs!app/dialog1'], (Dialog) ->
  routes:
    '/dialog1': 'cs!app/dialog1'
    '/dialog2/{width}/{height}': 'cs!app/dialog1'
    '/dialog3':
      structure:
        render: Dialog
        options:
          closeButton: true
          content: ['<p>dialog</p>']
          width: 400
          height: 100

    '/dialog4':
      title: 'Dialog Page'
      structure:
        render: Dialog
        options:
          closeButton: true
          content: ['<p>dialog</p>']
          width: 400
          height: 100
      
