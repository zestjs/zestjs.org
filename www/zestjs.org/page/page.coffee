define ['zest', 'css!./clearfix', 'less!./page'], ($z) ->
  _extend:
    section: 'REPLACE'
    options: 'APPEND'
    
  options:
    section: 'about'
    title: ''
    menu:
      '/why-zest': 'Why Zest?'
      '/start': 'Quick Start'
      '/docs': 'Documentation'
      # '/components': 'Component Library'
  
  load: (o) ->
    o.global.setTitle o.title
  
  template: (o) ->
    __menu = ""
    for link, item of o.menu
      __menu += "<li><a href='#{link}' #{if o.section == link.substr(1) then 'class="active"' else ''}>#{item}</a></li>"
    """
      <div class="header clearfix">
        <a href="/" class="logo">zestJS</a>
        <ul class="menu">
          #{__menu}
        </ul>
      </div>
      <div class="page-content">
        {`content`}
      </div>
    """