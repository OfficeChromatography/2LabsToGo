document.addEventListener("DOMContentLoaded", function() {
  var isLightOn = false; // Track the state of the light
  var lightTimeout; 
  function sendToMachine(value) {
    var data = {'gcode': value};
    console.log(data);
    $.ajax({
      method: 'POST',
      url: window.location.origin + '/send/',
      data: data,
      success: setHommingEndpointSucess,
      error: setHommingEndpointError,
    });
  }

  function setHommingEndpointSucess(data, textStatus, jqXHR) {
    console.log("Success!");
  }

  function setHommingEndpointError(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown);
  }

  function turnOffLight() {
    var gcode = 'M42P5S0';
    sendToMachine(gcode);
    isLightOn = false;
    $('#lighton').attr('disabled', false);
    $('#lightoff').attr('disabled', true);
  }

  $('#lighton').on('click', function() {
    if (!isLightOn) {
      var gcode = 'M42P5S255'; 
      sendToMachine(gcode);
      isLightOn = true;
      $('#lighton').attr('disabled', true);
      $('#lightoff').attr('disabled', false);
      lightTimeout = setTimeout(turnOffLight, 30000);
    }
  });

  $('#lightoff').on('click', function() {
    if (isLightOn) {
      clearTimeout(lightTimeout);
      turnOffLight();
    }
  });
});
 
  