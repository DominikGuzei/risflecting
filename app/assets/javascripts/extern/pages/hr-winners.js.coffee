
$(document).ready ->

  map = $('.map')
  pins = map.find '.pins .pin'
  legend = $('.legend')
  legendItems = legend.find '.locations a'

  # ====== HELPERS ========= #

  getLegendItemFor = (pin) ->
    id = $(pin).attr 'data-location'
    legendItem = legend.find ".locations a[data-location='#{id}']"
    return legendItem

  getId = (element) -> $(element).attr 'data-location'

  getPinById = (id) -> map.find ".pin[data-location='#{id}']"

  # ======= HANDLERS ========= #

  handlePinHover = ->
    $(this).addClass 'is-open'
    getLegendItemFor(this).addClass 'is-hovered'

  handlePinOut = ->
    $(this).removeClass 'is-open'
    getLegendItemFor(this).removeClass 'is-hovered'

  # ======= LISTENERS ======== #

  legendItems.hover (-> getPinById(getId(this)).addClass 'is-open'),
                    (-> getPinById(getId(this)).removeClass 'is-open')

  pins.hover handlePinHover, handlePinOut

  pins.click -> $(this).find('.link')[0].click()
