# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.switchButtons = ->
  $('.switch-wrapper input').switchButton({
    on_label: "Undergraduate",
    off_label: "Graduate"
  })

  labelled_button = (i,but) ->
    $(but).switchButton({ labels_placement: 'both', on_label: but.previousElementSibling.innerHTML, off_label: '' })
    $(but.previousElementSibling).hide();

  $('input[id^="skill_list_"]').each labelled_button
  $('input[id^="subject_list_"]').each labelled_button

$(document).ready ->
  $( "#order-dialog" ).dialog({
    autoOpen: true,
    width: 600,
    height: 'auto',
    fluid: true,
    buttons: {
      "OK": ->
        document.location = '/'
    }
  });
  $( "#order-dialog" ).dialog 'open'

inquire_dialog_setup = ->
  $( "#inquire-dialog" ).dialog({
    autoOpen: false,
    width: '600px',
    buttons: {
        "Send": ->
          $( "#target" ).submit();
          $( "#inquire-dialog" ).dialog 'close'
      }
    });
  $("span.ui-button-icon-primary.ui-icon.ui-icon-closethick").css({"margin-left": '-8px', "margin-top": '-8px'})

window.open_inquire_dialog = -> 
  $( "#inquire-dialog" ).dialog 'open'

$(document).ready ->
	inquire_dialog_setup()

$(document).on('page:change', window.switchButtons)
$(document).on('page:change', inquire_dialog_setup)
