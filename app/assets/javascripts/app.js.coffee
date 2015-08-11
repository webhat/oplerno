visible = true

$(window).scroll ->
  st = $(this).scrollTop()
  if(st > 190 && visible)
    $('#settings').hide()
    visible = false
  if(st < 190 && !visible)
    $('#settings').show()
    visible = true

delay = (ms, func) -> setTimeout func, ms

close = (e) ->
  e.stopPropagation()
  e.currentTarget.parentNode.style.display = 'none'

close_button = ->
  $('.close').click (e) ->
    close e

#$(document).on('page:load', load_cart)
$(document).on('page:load', close_button)
$(document).on('page:change', close_button)

$(document).on 'page:change', ->
  if window._gaq?
    _gaq.push ['_trackPageview']
  else if window.pageTracker?
    pageTracker._trackPageview()
