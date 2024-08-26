var captureEndpoint = window.location.origin+'/capture/takeimage'
var colorSelected = [{name: "red", value: "0"},
                    {name: "green", value: "0"},
                    {name: "blue", value: "0"}]

window.onload = function(){
    ExposureFormsControl($('#id_auto_exposure').val())
    AWBFormsControl($('#id_white_balance_auto_preset').val())
}


//////////////////////////////// Controls the Exposure Form ///////////////////////////
$('#id_auto_exposure').on('change',function(e){
    ExposureFormsControl(e.target.value)
})
function ExposureFormsControl(value){
    if(value=='0'){
        manualExposure()
    }
    else if(value==""){
        hideAllExposure()
    }
    else{
        autoExposure()
    }
}
function hideAllExposure(){
    $('#form_white_balance_auto_preset').hide()
    $('#form_exposure_time_absolute').hide()
    $('#form_analogue_gain').hide()
    $('#form_colour_gains').hide()
    $('#form_imagenumber').show()
    $('#form_delaytime').show()
}
function manualExposure(){
    $('#form_white_balance_auto_preset').show()
    $('#form_exposure_time_absolute').show()
    $('#form_analogue_gain').show()
    $('#usercontrolcontent').show()
    $('#form_colour_gains').hide()
    $('#form_imagenumber').show()
    $('#form_delaytime').show()
}
function autoExposure(){
    $('#usercontrolcontent').hide()
    $('#form_exposure_time_absolute').hide()
    $('#form_analogue_gain').hide()
    
    $('#form_colour_gains').hide()
    $('#form_imagenumber').show()
    $('#form_delaytime').show()
    
//    Hides Colour Gains
    $('#form_white_balance_auto_preset').hide()    
    $('#id_white_balance_auto_preset').val(1)
    $('#id_white_balance_auto_preset').change()
}

//////////////////////////////// Controls the AWB Form ///////////////////////////
$('#id_white_balance_auto_preset').on('change',function(e){
    AWBFormsControl(e.target.value)
})
function AWBFormsControl(value){
  if(value=='0'){
      $('#form_colour_gains').hide()
      
  }
  else if(value=='7'){
      $('#form_colour_gains').show()
      
  }
  else{
      $('#form_colour_gains').hide()
      
  }
}

$('#picker').colpick({
	flat:true,
	layout:'rgbhex',
	color:'000000',
	submit:0,
	onChange:loadNewRgb,
});

function loadNewRgb(hsb,hex,rgb,el,bySetColor){
    colorSelected[0].value = rgb.r
    colorSelected[1].value  = rgb.g
    colorSelected[2].value = rgb.b

}

$('#id_uv365_power').on('change',function(){
  $('#uv365text').val($(this).val())
})
$('#uv365text').on('change',function(){
  $('#id_uv365_power').val($(this).val())
})
$('#id_uv255_power').on('change',function(){
  $('#uv255text').val($(this).val())
})
$('#uv255text').on('change',function(){
  $('#id_uv255_power').val($(this).val())
})
$('#id_whitet_power').on('change',function(){
  $('#whitettext').val($(this).val())
})
$('#whitettext').on('change',function(){
  $('#id_whitet_power').val($(this).val())
})
$('#id_white').on('change',function(){
  $('#whitetext').val($(this).val())
})
$('#whitetext').on('change',function(){
  $('#id_white').val($(this).val())
})

var methodSelected = [{name: "id", value: "id"},{name: "filename", value: "filename"}]
function loadMethodSelected(){
    methodSelected[0].value = $('[aria-selected="true"]').find("a").attr("value_saved"),
    methodSelected[1].value = $('[aria-selected="true"]').text()
}

$('#shootbttn').on('click', function (e) {
  e.preventDefault();
  loadMethodSelected();
  let formData = $('form').serializeArray();
  formData.push({ name: 'colorSelected[]', value: colorSelected[0].value });
  formData.push({ name: 'colorSelected[]', value: colorSelected[1].value });
  formData.push({ name: 'colorSelected[]', value: colorSelected[2].value });

  formData.push({ name: 'methodSelected[]', value: methodSelected[0].value });
  formData.push({ name: 'methodSelected[]', value: methodSelected[1].value });
  
  $.ajax({
      method: 'POST',
      url: captureEndpoint,
      data: $.param(formData),
      success: shootMethodSuccess,
      error: shootMethodError,
  });
});

function shootMethodSuccess(data, textStatus, jqXHR){
  
    list_of_saved.loadList()
}
function shootMethodError(jqXHR, textStatus, errorThrown){}

//homming each axis
$('#hommingbttn').on('click', function (e) {
  e.preventDefault();
  gcode = 'M92Z400';
  sendToMachine(gcode);
  gcode = 'M203Z40';
  sendToMachine(gcode);
  gcode = 'M42P49S0';
  sendToMachine(gcode);
  gcode = 'M42P36S0';
  sendToMachine(gcode);
  gcode = 'G28X\nG28Y\nG28Z';
  sendToMachine(gcode);
});

//put camera into position
$('#cameraposbttn').on('click', function (e) {
    e.preventDefault()
    gcode = 'M92Z400' 
    sendToMachine(gcode)
    gcode = 'M203Z40'
    sendToMachine(gcode)
    gcode = 'M42P49S0'
    sendToMachine(gcode)
    gcode = 'M42P36S0'
    sendToMachine(gcode)
    gcode = 'G28Y\nG1X90Y161.6Z270' //Y value depends on each system
    sendToMachine(gcode)
  })

var list_of_saved = new listOfSaved("http://127.0.0.1:8000/capture/save/",
"http://127.0.0.1:8000/capture/list",
"http://127.0.0.1:8000/capture/load",
getData,
setData,
"http://127.0.0.1:8000/capture/deleteall"
);
  
function getData(){
    //check if this is working, because saving is done using take photo
    imageID = $("#image_id").attr("alt")
    data = $('form').serialize()+'&colorSelected'
    +JSON.stringify(colorSelected)
    +'&image_id='+imageID+'&note='+$('#notestextarea').val()
return data
};

function setData(data){
    if (typeof data.id_list === 'undefined') {
        
    } else {
    pos = data.id_list.length - 1

    $("#image_id").attr("src",data.url[pos]);
    $("#image_id").attr("alt",data.id_list[pos]);
    $("#image_id").attr("src-list",data.url);
    $("#image_id").attr("alt-list",data.id_list);
    $('#image_id').attr("position", pos)

    setConf(data.user_conf,data.leds_conf,data.camera_conf)}
};

function setConf(user_conf,leds_conf,camera_conf){
    for (var [key, value] of Object.entries(user_conf)) {
        $("#id_"+key).val(String(value));
    };
    // Load LEDs conf
    $("#id_uv255_power").val(leds_conf.uv255_power).change();
    $("#id_uv365_power").val(leds_conf.uv365_power).change();
    $("#id_whitet_power").val(leds_conf.whitet_power).change();
    $("#id_white").val(leds_conf.white).change();
    $('#picker').colpickSetColor({r:leds_conf.red, g:leds_conf.green, b:leds_conf.blue});

    // Load Camera conf
    for (var [key, value] of Object.entries(camera_conf)) {
        $("#id_"+key).val(String(value));}
}

function switchPicture(direction){
    src_list = $("#image_id").attr("src-list").split(',');
    alt_list = $("#image_id").attr("alt-list").split(',');
    position = $("#image_id").attr("position");
    if (direction == 'left'){
      position -= 1
      if (position < 0){
        position = src_list.length - 1;
      } 
    } else {
      position = parseInt(position) + 1
      if (position >= src_list.length){
        position = 0;
      }
    }
    
    $("#image_id").attr("src",src_list[position]);
    $("#image_id").attr("alt",alt_list[position]);
    $("#image_id").attr("position",position);
  }

  $('#right').on('click', function (e) {
    switchPicture('right');
    id = $("#image_id").attr('alt')
    $.ajax({
      method: 'GET',
      url:    window.location.origin+'/capture/getconfig/'+ id,
      success: getConfigMethodSuccess,
      error: getConfigMethodError,
    });
  })
  
  $('#left').on('click', function (e) {
    switchPicture('left');
    id = $("#image_id").attr('alt')
    $.ajax({
      method: 'GET',
      url:    window.location.origin+'/capture/getconfig/'+ id,
      success: getConfigMethodSuccess,
      error: getConfigMethodError,
    });
  })

  function getConfigMethodSuccess(data, textStatus, jqXHR){
      
      setConf(data.user_conf,data.leds_conf,data.camera_conf)
      $('#notestextarea').val(data.note)
  }
  function getConfigMethodError(jqXHR, textStatus, errorThrown){console.log('error')}

$(document).ready(function() {
    list_of_saved.loadList()
});
