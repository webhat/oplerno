# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.switchButtons = ->
	$('.switch-wrapper input').switchButton({
		on_label: "Undergraduate",
		off_label: "Graduate"
	})

	labelled_button = (i,but) ->
		$(but).switchButton({ labels_placement: 'both', on_label: but.previousElementSibling.innerText, off_label: '' })
		$(but.previousElementSibling).hide();

	$('input[id^="skill_list_"]').each labelled_button
	$('input[id^="subject_list_"]').each labelled_button



$(document).on('page:change', window.switchButtons)
