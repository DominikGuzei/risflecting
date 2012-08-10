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
      $container.empty().hide().html(response).fadeIn 400

  $('.buttons a[data-remote]').on 'ajax:error', ->
    alert('Es ist etwas schief gelaufen. Bitte noch einmal versuchen!')
