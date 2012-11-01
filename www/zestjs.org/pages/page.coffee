define ['less!./page'], () ->
  _extend:
    section: 'REPLACE'
    options: 'APPEND'
    
  options:
    section: 'about'
  
  template: (o) -> """
    <div class="header">
      <ul class="menu">
        <li><a href="install" #{if o.section == 'install' then 'class="active"' else ''}>Install</a></li>
        <li><a href="docs" #{if o.section == 'docs' then 'class="active"' else ''}>Docs / Tutorial</a></li>
        <li><a href="library" #{if o.section == 'library' then 'class="active"' else ''}>Component Library</a></li>
        <li><a href="about" #{if o.section == 'about' then 'class="active"' else ''}>About</a></li>
      </ul>
      <div class="logo"><span>zest</span>JS</div>
    </div>
    {`content`}
  """