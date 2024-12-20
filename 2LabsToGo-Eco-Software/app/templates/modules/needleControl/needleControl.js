var zero_position = 0

$('#steprangeN').on('change',function(){
  $('#steptextN').val($(this).val())
})
$('#steptextN').on('change',function(){
  $('#steprangeN').val($(this).val())
})


$('#up_arrowN').on('click',function(){ //E-
  mm = $('#steptextN').val()
  mm = Number(mm)
  zero_position = parseInt(zero_position)-parseInt(mm)
  value = 'G0E'+parseInt(zero_position)
  sendToMachine(value)
})

$('#down_arrowN').on('click',function(){ //E+
  mm = $('#steptextN').val()
  mm = Number(mm)
  zero_position = parseInt(zero_position)+parseInt(mm)
  value = 'G0E'+parseInt(zero_position)
  sendToMachine(value)
})

$('#hommingN').on('click',function(){
  gcode = 'G92E0'
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
  sendToMachine('M92Z400')
  sendToMachine('M203Z40')  
  sendToMachine('M42P49S0')
  sendToMachine('M42P36S0')
});

$('#needleModal').on('shown.bs.modal', function (e) {
  sendToMachine('G0X1');
})