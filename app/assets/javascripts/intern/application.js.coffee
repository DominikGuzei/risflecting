//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap_datepicker
//= require bootstrap_datepicker_de
//= require jquery_autosize
//= require_tree .

jQuery ->
  $('textarea').autosize()

  $('.upload-button').click ->
    if $('form input[type=file]').attr('value') != ""
      $(this).attr 'value', ' Datei wird hochgeladen … '

      # decouple this from the main thread, otherwise chrome won´t submit the form
      setTimeout (=> $(this).attr 'disabled', 'disabled' ), 0
