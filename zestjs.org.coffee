define [], () ->

  routes:
    # 'site' is the path mapping to 'www/zestjs.org'
    '@/': '/start' # @ means that it is an alias to the /start path
    '/why-zest': 'cs!site/why-zest'
    '/docs/zoe': 'cs!site/zoe'
    '/docs': 'cs!site/zest-docs'
    '/start': 'cs!site/start'
    '/components': 'cs!site/components'

  routeHandler: (req, res, next) ->
    req.pageOptions.title = null
    next();
