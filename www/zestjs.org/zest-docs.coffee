define ['cs!./doc-page/doc-page'], (DocsPage) ->
  render: DocsPage
  options:
    title: 'Documentation'
    section: 'docs'
    data: [
      chapterName: 'Zest Client'
      sections: [
        sectionName: '$z.render' # requirejs notes here
        # as before
        markdown: """
        """
      ,
        sectionName: '$z.render Server Notes'
        markdown: """
        """
      ,
        sectionName: 'RequireLESS'
        markdown: """
        """
      ,
        sectionName: 'CoffeeScript'
        markdown: """
        """
      ,
        sectionName: '$z.esc'
        markdown: """
        """
      ,
        sectionName: '$z.dispose' # mention instance css
        markdown: """
        """
      ,
        sectionName: '$z.Component' # include zoe, examples + zoe docs link
        markdown: """
        """
      ,
        sectionName: 'zoe' # separate page for this
        markdown: """
        """
      ,
        sectionName: 'selector'
        markdown: """
        """
      ,
        sectionName: 'rest'
        markdown: """
        """
      ,
        sectionName: '$z.route'
        markdown: """
        """
      ]
    ,
      chapterName: 'Zest Server'
      sections: [
        sectionName: 'zest.render'
        markdown: """
        """
      ,
        sectionName: 'zest.renderPage'
        markdown: """
        """
      ,
        sectionName: 'zest.createServer'
        markdown: """
        """
      ,
        sectionName: 'zest.init' #config info here
        markdown: """
        """
      ,
        sectionName: 'zest.startServer'
        markdown: """
        """
      ,
        sectionName: 'zest start'
        markdown: """
        """
      ,
        sectionName: 'zest start-nodemon'
        markdown: """
        """
      ,
        sectionName: 'zest create' # volo notes here
        markdown: """
        """
      ,
        sectionName: 'zest add'
        markdown: """
        """
      ]
    ,
      chapterName: 'Zest Server Modules'
      sections: [
        sectionName: 'Zest Core Module'
        markdown: """
        """
      ,
        sectionName: 'Module Registration & Loading'
        markdown: """
        """
      ,
        sectionName: 'Module.routes'
        markdown: """
        """
      ,
        sectionName: 'Module.handler'
        markdown: """
        """
      ,
        sectionName: 'Module.zestConfig' # plus module dependencies
        markdown: """
        """
      ]
    ]

    
