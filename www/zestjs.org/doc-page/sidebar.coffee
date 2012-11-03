define ['css!./sidebar'], ->
  options:
    content: ''
    sidebar: ''
  
  template: '''
    <div class="sidebar">{`sidebar`}</div>
    <div class="content-container">
      <div class="content">{`content`}</div>
    </div>
  '''
