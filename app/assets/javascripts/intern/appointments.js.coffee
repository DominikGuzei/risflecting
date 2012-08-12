jQuery ->
  $('#appointment_location').tooltip
    title: 'z.B. Sonnenhof, A-7022 Schattendorf'
    placement: 'right'
    trigger: 'focus'

  $('.buttons a[data-remote]').on 'ajax:beforeSend', ->
    $(this).parent().find('a').addClass 'disabled'
    $(this).data 'title', $(this).text()
    $(this).text 'wird verarbeitet …'

  $('.buttons a[data-remote]').on 'ajax:complete', ->
    $(this).parent().find('.btn').removeClass 'disabled'
    $(this).text $(this).data('title')

  $('.buttons a[data-remote]').on 'ajax:success', (event, response, status) ->
    $container = $(this).parent()
    $container.find('.btn').fadeOut 200, ->
      $container.css('opacity', 0).html(response).animate { 'opacity': 1 }, 400
