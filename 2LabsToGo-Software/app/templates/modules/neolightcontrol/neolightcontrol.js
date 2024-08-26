document.addEventListener("DOMContentLoaded", function() {
    var isLightOn = false; // Track the state of the light
  
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
  
    $('#lighton').on('click', function() {
      if (!isLightOn) {
        var gcode = 'G93R0G0B0W255'; 
        sendToMachine(gcode);
        isLightOn = true;
        $('#lighton').attr('disabled', true);
        $('#lightoff').attr('disabled', false);
      }
    });
  
    $('#lightoff').on('click', function() {
      if (isLightOn) {
        var gcode = 'G93R0G0B0W0'; 
        sendToMachine(gcode);
        isLightOn = false;
        $('#lighton').attr('disabled', false);
        $('#lightoff').attr('disabled', true);
      }
    });
  });
  