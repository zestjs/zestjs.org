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
    footer: """
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-38168196-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
    """