define ['css!./sidebar'], ->
  options:
    content: ''
    sidebar: ''
  
  template: '''
    <div class="content-container">
      <div class="content">{`content`}</div>
    </div>
    <div class="sidebar">{`sidebar`}</div>
  '''
