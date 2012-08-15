
jQuery ->

  circleInfoText = $('#circle-info-text').hide()
  circleRisflectingText = $('#circle-navigation h2')

  mouseInHandler = ->
    titleOfHoveredLink = ($(this).attr 'title')
    circleInfoText.text(titleOfHoveredLink).fadeIn('slow')
    circleRisflectingText.hide()

  mouseOutHandler = ->
    circleInfoText.fadeOut('fast')
    circleRisflectingText.fadeIn('slow')

  $('#circle-links a').hover(mouseInHandler, mouseOutHandler)