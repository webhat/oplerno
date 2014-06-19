cta_sign_up = ->
  $( "#dialog" ).dialog({
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 100
      },
      hide: {
        effect: "blind",
        duration: 100
      },
      buttons: {
        "Sign Up": ->
          document.location = '/users/sign_up'
        "Sign In": ->
          document.location = '/users/sign_in'
      }
    });
  $( "#dialog" ).dialog 'open' 


$(document).on 'click', '.oplerno-cta', (e) ->
  e.stopPropagation();
  cta_sign_up()


