new_link = ->
  len = $('.nested-fields').length
		if len < 5
			nf = $("<div class='nested-fields'><li><label class='label' for='name_#{len}'>Link</label><input id='name_#{len}' name='user[links][#{len}][name]' /></li><li><label class='label' for='url_#{len}'>URL</label><input id='url_#{len}' name='user[links][#{len}][url]' /></li></div>")
			$('.box').append nf
			
set_link = ->
	$($('.nested-fields:last > li > input')[1]).blur window.should_have_new_link

window.should_have_new_link = (elem,e) ->
	$(e).removeAttr 'onblur'
	new_link()
	set_link()

$ ->
	set_link()
$(document).on('page:load', set_link)
