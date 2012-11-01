define [
  'cs!./com/page'
  'cs!./com/contents'
  'cs!./com/documentation'
  'cs!./com/line-break'
  'cs!./data/docs.json'
], (Page, Contents, Docs, LineBreak, docData) ->
  structure: Page,
  options:
    section: 'docs'
    content:
      type: 'Documentation'
      template: '''
        <div class="sidebar">{`sidebar`}</div>
        <div class="content">{`content`}</div>
      '''
      sidebar: [
        '<h1 class="page-title">Docs / Tutorial</h1>'
      ,
        structure: LineBreak
        options:
          top: 'd9d9d9'
          bottom: 'ffffff'
      ,
        structure: Contents
        options:
          contents: docData
      ]
      content:
        structure: Docs
        options:
          contents: docData
        
      css: '''
        h1.page-title {
          margin: 0 0 20px 0;
          font-size: 18px;
          font-family: "PT-sans", arial, sans-serif;
          font-weight: 100;
          text-transform: uppercase;
        }
        .sidebar {
          width: 300px;
          position: fixed;
          background-color: #F4F4F4;
          border-right: 1px solid #D6D6D6;
          margin-top: 40px;
          padding: 20px;
          height: 100%;
          min-height: 1000px;
        }
      '''