var zero_position = [5,0]

$('#steprange').on('change',function(){
  $('#steptext').val($(this).val())
})
$('#steptext').on('change',function(){
  $('#steprange').val($(this).val())
})

$('#right_arrow').on('click',function(){ //X+
  mm = $('#steptext').val()
  mm = Number(mm)
  zero_position = [parseInt(zero_position[0])+parseInt(mm), zero_position[1]]
  value = 'G0X'+parseInt(zero_position[0])
  sendToMachine(value)
})

$('#left_arrow').on('click',function(){ //X-
  mm = $('#steptext').val()
  mm = Number(mm)
  zero_position = [parseInt(zero_position[0])-parseInt(mm), zero_position[1]]
  value = 'G0X'+parseInt(zero_position[0])
  sendToMachine(value)
})

$('#up_arrow').on('click',function(){ //Y+
  mm = $('#steptext').val()
  mm = Number(mm)
  zero_position = [zero_position[0], parseInt(zero_position[1])+parseInt(mm)]
  value = 'G0Y'+parseInt(zero_position[1])
  sendToMachine(value)
})

$('#down_arrow').on('click',function(){ //Y-
  mm = $('#steptext').val()
  mm = Number(mm)
  zero_position = [zero_position[0], parseInt(zero_position[1])-parseInt(mm)]
  value = 'G0Y'+parseInt(zero_position[1])
  sendToMachine(value)
})

$('#homming').on('click',function(){
  gcode = 'G28XY'
  sendToMachine(gcode)
  zero_position = [0,0]
})


function movement(direction){
  console.log(direction)
  mm = $('#steptext').val()
  mm = Number(mm)
  value = 'G0'+direction+mm
  $('#currentPosition').text('x: ' + zero_position[0] + '    y: ' +zero_position[1])
}

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
  function setHommingEndpointSucess(data, textStatus, jqXHR){
    console.log(data);  
  }
    
  function setHommingEndpointError(jqXHR, textStatus, errorThrown){
    console.log(errorThrown)
  }
    
}
