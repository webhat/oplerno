# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.switch-wrapper input').switchButton()
	$('input[id^="skill_list_"]').switchButton()
	$('input[id^="subject_list_"]').switchButton()
