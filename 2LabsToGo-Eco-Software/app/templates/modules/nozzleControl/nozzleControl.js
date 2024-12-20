var zero_position = 0
$('#speedrangeN').on('change',function(){
  $('#speedtextN').val($(this).val())
})
$('#speedtextN').on('change',function(){
  $('#speedrangeN').val($(this).val())
})

$('#steprangeN').on('change',function(){
  $('#steptextN').val($(this).val())
})
$('#steptextN').on('change',function(){
  $('#steprangeN').val($(this).val())
})
$('#up_arrowN').on('click',function(){
  gcode = movement('E-')
  sendToMachine(gcode)
})
$('#down_arrowN').on('click',function(){
  gcode = movement('E')
  sendToMachine(gcode)
})
$('#hommingN').on('click',function(){
  gcode = 'G41\nG92E0'
  sendToMachine(gcode)
  zero_position = 0
  $('#currentPositionN').text('e: ' + zero_position)
})


function movement(direction){
  mm = $('#steptextN').val()
  value = 'G0'+direction+$('#steptextN').val()
  if(direction.includes("-")){
    zero_position[0]=parseInt(zero_position[0])-parseInt(mm);
  }
  else{
    zero_position[0]+=parseInt(mm);
  }

  $('#currentPositionN').text('x: ' + zero_position)
  return value;
}

$( document ).ready(function() {
  sendToMachine("G28XY")
});
