define [], () ->

  routes:
    # aliases
    # '@' indicates we map the route to another route
    '@/':           '/start'
    
    # routes
    '/why-zest':    'cs!site/why-zest'
    '/docs':        'cs!site/zest-docs'
    '/start':       'cs!site/start'
    '/components':  'cs!site/components'

  page:
    head: """<meta name="viewport" content="width=device-width">"""
