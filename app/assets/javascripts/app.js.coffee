$ -> load_cart()

load_cart = () ->
	callback = (response) -> cart_count response
	$.get '/carts/mycart.json', {}, callback, 'json'

cart_count = (response) ->
  $('.cartcount').text response.length
  console.log response

visible = true;

$(window).scroll ->
	st = $(this).scrollTop();
	if(st > 190 && visible)
		$('#settings').hide();
		visible = false
	if(st < 190 && !visible)
		$('#settings').show();
		visible = true

delay = (ms, func) -> setTimeout func, ms

close = (e) ->
  console.log 'close'
  console.log e
  e.stopPropagation()
  e.currentTarget.parentNode.style.display = 'none'

close_button = ->
  console.log 'close_button'
  $('.close').click (e) ->
    close e

bother_teacher = (e) ->
	if(document.cookie.indexOf('popup') != -1)
		return
	console.log 'hi teacher'
	# A/B testing here...
	test = Math.round(Math.random()*2)
	if test == 0
		$('.atest').show()
	else
		$('.btest').show()
	$('.atest>.close').click ->
		document.cookie = 'popup=a;path=/'
		console.log 'no alert'
	$('.btest>.close').click ->
		document.cookie = 'popup=b;path=/'
		console.log 'no alert'

$(document).on('page:load', load_cart)
$(document).on('page:load', bother_teacher)
$(document).on('page:change', bother_teacher)
$(document).on('page:load', close_button)
$(document).on('page:change', close_button)

$(document).on 'page:change', ->
	if window._gaq?
		_gaq.push ['_trackPageview']
	else if window.pageTracker?
		pageTracker._trackPageview()
