$ ->
  $(document).ready ->
    callback = (response) -> cart_count response
    $.get '/carts/mycart.json', {}, callback, 'json'

cart_count = (response) ->
  $('#cartcount').text response.length
  console.log response


$ ->
  $(document).ready ->
    authyUI = Authy.UI.instance
    authyUI.setTooltip("Two-Factor Authentication", "You can your token from your cellphone");

    window.authy_help

window.authy_help = () ->
  $('#authy-help').click (e) ->
    e.stopPropagation();
