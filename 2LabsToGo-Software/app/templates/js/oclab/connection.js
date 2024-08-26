window.onload = function(){}

// Send the POST request when 'Connect' button is pressed
$('.connection-form').submit(function(event){
    event.preventDefault()
    var $formData = $(this).serialize()
    console.log($formData);
    var $endpoint = window.location.href
    $.ajax({
        method: 'POST',
        url:    $endpoint,
        data:   $formData,
        success: connectionFormSuccess,
        error: connectionFormError,
    })
    function connectionFormSuccess(data, textStatus, jqXHR){}
    function connectionFormError(jqXHR, textStatus, errorThrown){}
})
$('#disconnectBttn').on('click',function(e){
  e.preventDefault();
  chatSocket.close()
  $.ajax({
    method: 'POST',
    url:    window.location.origin + '/connection/',
    data:   '&DISCONNECT',
    success: disconnectSuccess,
    error: disconnectError,
  })
  function disconnectSuccess(data, textStatus, jqXHR){}
  function disconnectError(jqXHR, textStatus, errorThrown){}
})
