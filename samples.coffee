define ['require', 'zest-server'], (require, zest) ->
  routes:

    '/dialog':
      title: 'Dialog Page'
      body: 
        render: '@cs!app/dialog6'
        options:
          content: "<p>Welcome to ZestJS.</p>"
          confirmText: 'Yay'
          width: 300,
          height: 50

    '/dialog1': 
      title: 'Dialog Page'
      body: '@cs!app/dialog6'

    '/dialog2/{width}/{height}': 
      title: 'Dialog Page'
      body: '@cs!app/dialog7'

    '/dialog3':
      title: 'Dialog Page'
      body: '@cs!app/dialog7'
      options:
        width: 400
        height: 50
        confirmText: 'Ok'
      load: (o) ->
        o.content = '<p>The time is ' + (new Date()).toLocaleTimeString() + '</p>'

    '/dialog4':
      title: 'Dialog Page'
      requireMain: 'test'
      body: '@cs!app/dialog6'
      options:
        width: 400
        height: 50
        confirmText: 'Ok'
        content:
          load: (o, done) ->
            setTimeout(done, 3000)
          render: (o) ->
            '<p>Heavy data query complete...</p>'


  # handle post requests to /component/moduleId, with JSON POST options
  globalHandler: (req, res, next) ->
    if req.method != 'POST'
      return next();

    if !(routeMatch = req.url.match /^\/render:cs!app\/dialog6/)
      return next();

    moduleId = 'cs!app/dialog6'

    postData = []
    req.on 'data', (chunk) ->
      postData.push(chunk)
      if postData.length > 1e4
        res.writeHead(413, {'Content-Type': 'text/html'});
        req.connection.destroy()

    req.on 'end', () ->
      require [moduleId], (com) ->
        zest.render com, JSON.parse(postData.join('')), res
      , (err) ->
        res.writeHead(404, {
          'Content-Type': 'text/html'
        });
        res.end('Component not found. \n' + err.toString());

      
