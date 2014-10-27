$ ->
	authyUI = Authy.UI.instance
	if(typeof authyUI.setTooltip == 'function')
		authyUI.setTooltip("Two-Factor Authentication", "You can your token from your cellphone");

	window.authy_help

window.authy_help = () ->
  $('#authy-help').click (e) ->
    e.stopPropagation();
