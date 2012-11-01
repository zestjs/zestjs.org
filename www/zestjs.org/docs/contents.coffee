define ['zest', 'less!./contents'], ($z) ->
  $z.create([$z.Component],
    type: 'Contents'
    ###
    options:
      contents: [
        chapterName: 'This is a chapter'
        sections: [
          sectionName: 'This is a section'
        ]
      ]
    ###
    template: (o) ->
      contents = ""
      for chapter in o.contents
        contents += "<h1>#{chapter.chapterName}</h1>"
        for section in chapter.sections
          contents += "<h2>#{section.sectionName}</h2>"
      
      """
        <div class="contents">
          #{contents}
        </div>
      
        <div>
          <p>is a paragraph</p>
        </div>
      """
    
    construct: (o) ->
      this.$chapters = this.$('h1')
      this.$sections = this.$('h2')
      this.$paragraph = this.$('p')[0]
      this.$paragraph.addEventListener 'click', =>
        alert('you clicked the paragraph')
      this.$chapters[0].addEventListener 'click', =>
        this.chapterSelect()
    prototype:
      chapterSelect: ->
        alert('you clicked a chapter')
  )
