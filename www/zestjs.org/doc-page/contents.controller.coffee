define ['zest', 'jquery'], ($z, $) ->
  $z.create([$z.Component],  
    prototype:
      init: ->
        @$chapters = @$('h1 a')
        @$sections = @$('h2 a')
        @$scrollContainer = $(@el).children()

        @chapterPositions = {}
        @sectionPositions = {}
        
        # assuming a knowledge of the documentation component - this creates an unnecessary coupling, but
        # they are designed to work together only
        $chapters = $('.documentation h1')
        $sections = $('.documentation h2')
        
        # run through chapters and sections collecting their scroll positions
        for $chapter in $chapters
          $chapter = $($chapter)
          @chapterPositions[$chapter.text()] = $chapter.position().top
        
        # store the section positions, keyed by chapter themselves
        for $section in $sections
          $section = $($section)
          chapterName = $section.prevAll('h1:first').text()
          @sectionPositions[chapterName] = @sectionPositions[chapterName] || {}
          @sectionPositions[chapterName][$section.text()] = $section.position().top
        
        # add the scroll event
        self = @
        scrollEvent = ->
          if $(window).width < 800
            return
          scrollPos = $(window).scrollTop() + 100
          
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
            # hide all sections not in this chapter
            self.$sections.css 'display', 'none'

            self.$chapters.filter(->
              $(@).text() == curChapter
            ).addClass('active').parent().nextUntil('h1').children().css 'display', 'block'
            
          if (curSection != self.curSection)
            self.curSection = curSection
            self.$sections.removeClass 'active'
            sectionPos = self.$sections.filter(->
              $(@).text() == curSection
            ).addClass('active').position()
            
          # get the chapter position within the chapter scroll
          scrollHeight = self.$scrollContainer.height()
          scrollTop = self.$scrollContainer.scrollTop()
          bottomPos = scrollTop + scrollHeight
          maxScroll = $(document.body).height() - $(window).height()
          
          # scroll the contents
          if sectionPos && ((sectionPos.top > scrollHeight - 20) || scrollPos >= maxScroll)
            newTop = scrollTop + (sectionPos.top - scrollHeight + 20)
            self.$scrollContainer.stop().animate(
              scrollTop: if scrollPos >= maxScroll then self.$scrollContainer.prop('scrollHeight') else newTop
            , 150)
          
          if sectionPos && sectionPos.top < 20
            newTop = scrollTop + (sectionPos.top - 20)
            self.$scrollContainer.stop().animate(
              scrollTop: if newTop < 50 then 0 else newTop
            , 150)
            
        $(window).scroll(scrollEvent)
        scrollEvent()
  )