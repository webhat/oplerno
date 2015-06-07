application_setup = ->
  $( "#application-dialog" ).dialog({
    autoOpen: false,
    width: '600px',
    buttons: {
        "Close": ->
          $( "#target" ).submit()
          $( "#application-dialog" ).dialog 'close'
      }
    })
  $(".ui-dialog-titlebar-close").text('×')
  $('.ui-dialog-buttonset>button').addClass('btn').addClass('btn-danger')
  $("span.ui-button-icon-primary.ui-icon.ui-icon-closethick").css({"margin-left": '-8px', "margin-top": '-8px'})

window.open_application_dialog = ->
  $( "#application-dialog" ).dialog 'open'

company_tooltips = ->
  $('[data-toggle="tooltip"]').tooltip()

$(document).ready ->
  application_setup()
  company_tooltips()

$(document).on('page:change', application_setup)
$(document).on('page:change', company_tooltips)

