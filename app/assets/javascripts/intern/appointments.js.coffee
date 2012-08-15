jQuery ->
  $('#appointment_location').tooltip
    title: 'z.B. Sonnenhof, A-7022 Schattendorf'
    placement: 'right'
    trigger: 'focus'

  $('.buttons').on 'ajax:beforeSend', 'a[data-remote]', ->
    $(this).parent().find('a').addClass 'disabled'
    $(this).data 'title', $(this).text()
    $(this).text ' lädt … '

  $('.buttons').on 'ajax:complete', 'a[data-remote]', ->
    $(this).parent().find('.btn').removeClass 'disabled'
    $(this).text $(this).data('title')

  $('.buttons').on 'ajax:success', 'a[data-remote]', (event, response, status) ->
    $container = $(this).parent()
    $container.animate { 'opacity': 0 }, 300, ->
      $container.css('opacity', 0).html(response).animate { 'opacity': 1 }, 400
