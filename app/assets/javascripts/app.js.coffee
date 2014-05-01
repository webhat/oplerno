$ -> load_cart()

load_cart = () ->
	callback = (response) -> cart_count response
	$.get '/carts/mycart.json', {}, callback, 'json'

cart_count = (response) ->
  $('.cartcount').text response.length
  console.log response


$ ->
	authyUI = Authy.UI.instance
	if(typeof authyUI.setTooltip == 'function')
		authyUI.setTooltip("Two-Factor Authentication", "You can your token from your cellphone");

	window.authy_help

window.authy_help = () ->
  $('#authy-help').click (e) ->
    e.stopPropagation();

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

$(document).on('page:load', load_cart)

$(document).on 'page:change', ->
	if window._gaq?
		_gaq.push ['_trackPageview']
	else if window.pageTracker?
		pageTracker._trackPageview()
