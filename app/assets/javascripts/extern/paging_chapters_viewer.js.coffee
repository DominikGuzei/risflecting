#= require ./chapters_viewer

class risflecting.PagingChaptersViewer extends risflecting.ChaptersViewer
  
  previousChapterButton: null
  nextChapterButton: null
  
  constructor: (options) ->
    @previousChapterButton = options.previousChapterButton
    @nextChapterButton = options.nextChapterButton
    
    super(options)
  
  activateChapter: (chapterNumber) ->
    super(chapterNumber)
    @renderPagingButtons(chapterNumber)
  
  renderPagingButtons: (chapterNumber) ->
    totalChapters = @chapters.length
    
    if @currentChapter > 1 
      @previousChapterButton.show()
      @previousChapterButton.attr('href', "#chapter-#{@currentChapter-1}")
    else 
      @previousChapterButton.hide()
    
    if @currentChapter < totalChapters 
      @nextChapterButton.show()
      @nextChapterButton.attr('href', "#chapter-#{@currentChapter+1}")
    else @nextChapterButton.hide()