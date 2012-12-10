define ['require', 'cs!app/dialog1', 'zest-server'], (require, Dialog, zest) ->
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
      requireMain: 'test'
      body: '@cs!app/dialog2'
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

    if !(routeMatch = req.url.match /^\/render:cs!app\/dialog2/)
      return next();

    moduleId = 'cs!app/dialog2'

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

      
