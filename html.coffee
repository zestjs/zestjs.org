define
  ###
  options:
    id: null
    title: ''
    scripts: []
    main: ''
    structure: ''
    options: {}
    requireConfig: {}
    baseUrl: ''
  ###
  
  options:
    type: null
  
  template: (o) -> """
    <!doctype html>
    <html>
    <head>
      <meta charset='utf-8'>
      {`title`}
      <link rel="shortcut icon" href="/favicon.ico" />
      <script type='text/javascript'>var require = #{JSON.stringify(o.requireConfig)};</script>
      <script type='text/javascript' src='#{o.requireConfig.baseUrl}/require.js' data-main='#{if o.main then o.main else ''}'></script>
      
      #{ "<script type='text/javascript' src='#{o.requireConfig.baseUrl}/" + script + "'></script>" for script in o.scripts }
    </head>
    <body>{`body`}</body>
    </html>
  """
  
  # special title region allows waiting until a subcomponent calls the 'setTitle' global method option
  # before rendering the page title. 'null' indicates a deferred title.
  # The same principle can be used to defer any head properties for component-based loads.
  # NB if title = null for deferred, and o.global.setTitle is never called, app will hang.
  title:
    options:
      id: null
    template: (o) -> "<title>#{o.title}</title>"
    load: (o, done) ->
      if o.title != null
        return done()
      o.global.setTitle = (title) ->
        o.title = title
        done()
  
  body: (o) ->
    structure: o.structure
    options: o.options
