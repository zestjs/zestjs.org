define ['zest', 'cs!../page/line-break', 'is!browser?jquery', 'less!./contents'], ($z, LineBreak, $) ->
  $z.create([$z.Component],
    type: 'Contents'
    options:
      contents: [
        chapterName: 'This is a chapter'
        sections: [
          sectionName: 'This is a section'
        ]
      ]
    template: (o) ->
      contents = ""
      first = true
      for chapter in o.contents
        contents += "<h1><a #{if first then "class='active' " else ""}href='##{chapter.chapterName}'>#{chapter.chapterName}</a></h1>"
        for section in chapter.sections
          contents += "<h2><a #{if first then "class='active' " else ""}href='##{section.sectionName}'>#{section.sectionName}</a></h2>"
          first = false
      
      """
        <div class="contents">
          #{contents}
          <div class='contents-footer'>
            {`contentsFooter`}
          </div>
        </div>
      """
    
    contentsFooter: [
      structure: LineBreak
      options:
        top: '#d9d9d9'
        bottom: '#ffffff'
    , """
      <a class='github' href='https://github.com/zestjs' target='_blank'>Github</a>
      <a class='built-zest' href='https://github.com/zestjs/zestjs.org' target='_blank'>Built with ZestJS</a>
    """]
    
    construct: (o) ->
      @$chapters = @$('h1 a')
      @$sections = @$('h2 a')
      
      # add the contents scroll detection
      @constructor.detectScroll.call(@)
      
    detectScroll: ->
      @chapterPositions = {}
      @sectionPositions = {}
      
      # assuming a knowledge of the documentation component - this creates an unnecessary coupling, but
      # they are designed to work together only
      $chapters = $('.documentation h1')
      $sections = $('.documentation h2')
      
      # run through chapters and sections collecting their scroll positions
      for $chapter in $chapters
        $chapter = $($chapter)
        @chapterPositions[$chapter.text()] = $chapter.offset().top
      
      # store the section positions, keyed by chapter themselves
      for $section in $sections
        $section = $($section)
        chapterName = $section.prevAll('h1:first').text()
        @sectionPositions[chapterName] = @sectionPositions[chapterName] || {}
        @sectionPositions[chapterName][$section.text()] = $section.offset().top
      
      # add the scroll event
      self = @
      scrollEvent = ->
        if $(window).width < 800
          return
        scrollPos = $(window).scrollTop() + 80
        
        
        # lookup the current chapter from the scroll position
        # get the chapter with the maximum top, less than the scroll position
        maxPos = 0
        for chapter, pos of self.chapterPositions
          firstChapter = chapter if !firstChapter
          if pos < scrollPos && pos > maxPos
            maxPos = pos
            curChapter = chapter
        
        curChapter = firstChapter if !curChapter
          
        
        # lookup the current section
        maxPos = 0
        for section, pos of self.sectionPositions[curChapter]
          firstSection = section if !firstSection
          if pos < scrollPos && pos > maxPos
            maxPos = pos
            curSection = section
        
        curSection = firstSection if !curSection
        
        # finally highlight the chapter and section
        if (curChapter != self.curChapter)
          self.curChapter = curChapter
          self.$chapters.removeClass 'active'
          self.$chapters.filter(":contains(#{curChapter})").addClass 'active'
          
        if (curSection != self.curSection)
          self.curSection = curSection
          self.$sections.removeClass 'active'
          self.$sections.filter(":contains(#{curSection})").addClass 'active'
          
      $(window).scroll(scrollEvent)
      scrollEvent()
        
      
    prototype:
      chapterSelect: ->
        alert('you clicked a chapter')
  )
