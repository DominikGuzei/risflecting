#= require extern/_paging_chapters_viewer

jQuery ->
  
  new risflecting.PagingChaptersViewer 
    links: $('#chapter-navigation li') 
    chapters: $('article section')
    previousChapterButton: $('#previous-chapter-button')
    nextChapterButton: $('#next-chapter-button')