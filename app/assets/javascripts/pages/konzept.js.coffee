# Simple chapter navigation for content of 'konzept' page

jQuery ->
  currentChapter = 0
  
  activateChapter = (oldIndex, newIndex) ->
    $("aside li:eq(#{oldIndex}), article section:eq(#{oldIndex})").removeClass 'active'
    $("aside li:eq(#{newIndex}), article section:eq(#{newIndex})").addClass 'active'
  
  # navigation between chapters: clicking on links in the sidebar
  $('aside li').mouseup ->
    clickedLinkIndex = $(this).index();
    activateChapter(currentChapter, clickedLinkIndex)
    currentChapter = clickedLinkIndex