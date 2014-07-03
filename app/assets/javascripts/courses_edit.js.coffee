image_picker_dialog_setup = ->
  console.log 'dialog'
  $( "#image-picker-dialog" ).dialog({
    autoOpen: false,
    width: '800px',
    buttons: {
        "Save": ->          
            $.ajax({
                type: 'POST',
                url: $('#image-picker-dialog').attr('data-form-url'),
                data: $('#image-picker-dialog :input').serialize(),
                success: (xml, status, error) -> 
                  console.log(xml);
                  $('#course-avatar').css('background-image',"url(#{xml})")
                error: (xml, status, error) -> 
                  $('#image-picker-dialog').html('<p><strong>Error Code:</strong> '+status+'</p><p><strong>Explanation:</strong> '+error+'</p>');
            })
        Cancel: ->
            $(this).dialog('close');
      }
    });
  $("select").imagepicker({ hide_select : true })
  $("img.image_picker_image").lazyload({ effect : "fadeIn" })
  $("span.ui-button-icon-primary.ui-icon.ui-icon-closethick").css({"margin-left": '-8px', "margin-top": '-8px'})

$(document).ready ->
  image_picker_dialog_setup

window.image_picker_open = ->
  $( "#image-picker-dialog" ).dialog 'open'

$(document).on('page:change', image_picker_dialog_setup)
