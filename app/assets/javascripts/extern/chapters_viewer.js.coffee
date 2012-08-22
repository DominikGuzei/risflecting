#= require vendor/jquery.hashchange

class risflecting.ChaptersViewer
  links: null
  chapters: null
  
  currentChapter: 0
  
  activeLink: null
  activeChapter: null
  
  constructor: (options) ->
    @links = options.links
    @chapters = options.chapters

    $(window).hashchange => @activateChapter @getChapterNumberFromUrl()
    $(window).trigger 'hashchange'
  
  getChapterNumberFromUrl: -> 
    hash = location.hash
    chapterNumberString = hash.substring(hash.indexOf('-') + 1)
    parseInt(chapterNumberString)
  
  activateChapter: (chapterNumber) ->
    chapterNumber = 1 if isNaN chapterNumber
    
    @activeLink.removeClass('active') if @activeLink
    @activeChapter.removeClass('active') if @activeChapter
    
    @activeLink = @links.eq(chapterNumber - 1).addClass('active')
    @activeChapter = @chapters.eq(chapterNumber - 1).addClass('active')
    
    @currentChapter = chapterNumber
    
    @scrollToTop()
    
  scrollToTop: -> $(window).scrollTop(0)