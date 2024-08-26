function sendToMachine(value){
    data={'gcode':value}
    console.log(data);
    $.ajax({
      method: 'POST',
      url:    window.location.origin+'/send/',
      data:   data,
      success: setHommingEndpointSucess,
      error: setHommingEndpointError,
    })
    function setHommingEndpointSucess(data, textStatus, jqXHR){}
    function setHommingEndpointError(jqXHR, textStatus, errorThrown){}
  }

  $('#speedrange').on('change',function(){
    $('#speedtext').val($(this).val())
  })
  $('#speedtext').on('change',function(){
    $('#speedrange').val($(this).val())
  })

$('#fancontrol').on('click',function(){
    gcode = 'M42 I1 P9 S'+ $('#speedtext').val()
    sendToMachine(gcode)
})