define ['cs!./doc-page/doc-page'], (DocsPage) ->
  structure: DocsPage
  options:
    title: 'Documentation'
    section: 'docs'
    data: [
      chapterName: 'welcome'
      sections: [
        sectionName: 'welcome to zest'
        markdown: '''
          This is a heading
          ===
    
          *This is italic*
        '''
      ]
    ,
      chapterName: 'What is it?'
      sections: [
        sectionName: 'What is it?'
        markdown: '''
          The core of zest is simply this:
          
          ```
            $z.render('something', {options}, somewhere);
          ```
          
          Heading
          ====
          
          * bullet1
          * this is a bullet point
          
          
          
          
        '''
      ,
        sectionName: 'Template'
        markdown: '''
          Templates are cool
        '''
      ]
    ,
      chapterName: 'The Basics'
      sections: [
        sectionName: '$z.Component'
        markdown: '''
          $z.Component does stuff
        '''
      ]
    ,
      chapterName: 'Another'
      sections: [
        sectionName: 'welcome'
        markdown: '''
          [http://www.google.com](this is a link)
          
          asdf
          ===
          
          1. sdf
          2. asdf
        '''
      ]
    ]

    
