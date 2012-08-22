#= require extern/chapters_viewer

jQuery ->
  
  new risflecting.ChaptersViewer 
    links: $('#faqs-navigation li') 
    chapters: $('article section')