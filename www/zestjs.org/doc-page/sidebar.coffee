define ['css!./sidebar'], ->
  options:
    content: ''
    sidebar: ''
  
  render: '''
    <div class="content-container">
      <div class="content">{`content`}</div>
    </div>
    <div class="sidebar">{`sidebar`}</div>
  '''
