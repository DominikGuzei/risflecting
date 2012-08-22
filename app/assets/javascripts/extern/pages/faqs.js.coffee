#= require extern/chapters_viewer

jQuery ->
  
  chaptersController = new risflecting.ChaptersViewer 
    links: $('#faqs-navigation li') 
    chapters: $('article section')