
jQuery ->

  circleInfoText = $('#circle-info-text').hide()
  circleRisflectingText = $('#circle-navigation h2')

  cancelCurrentAnimations = ->
    circleInfoText.stop().hide()
    circleRisflectingText.stop().hide()

  mouseInHandler = ->
    cancelCurrentAnimations()
    titleOfHoveredLink = ($(this).attr 'title')
    circleInfoText.text(titleOfHoveredLink).fadeIn('slow')

  mouseOutHandler = ->
    circleInfoText.stop().fadeOut('fast')
    circleRisflectingText.fadeIn('slow')

  $('#circle-links a').hover(mouseInHandler, mouseOutHandler)