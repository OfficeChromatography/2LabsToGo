// Execute every time something happens wi
// let flowRateChart = new flowRateGraph()

var table_obj = new TableWaitingTime();


$(".development-flowrate-insidence").on("change", function (){
  flowrateCalc()
})


$(".change-graph-size-parameter").on("change", function(){
  plotPreview.changeGraphSize()
  mainCalculations()
})

$("#id_fluid").change(function(){
  $(this).val()=='Specific' ? $('#specificFluidTable').show() : $('#specificFluidTable').hide()
});

function importCsv(file) {
  const reader = new FileReader();

  reader.onload = function(event) {
      const csvData = event.target.result;
      const lines = csvData.split('\n');
      let formData = {};
      let waitingTimeData = [];
      let isWaitingTimeSection = false;

      lines.forEach(line => {
          if (!line.trim()) return;

          let key, value;

          if (line.startsWith('flowrate')) {
              key = 'flowrate';
              value = line.substring(line.indexOf('['));
          } else {
              [key, value] = line.split(',', 2);
          }

          if (key === 'Waiting Time Data') {
              isWaitingTimeSection = true;
              return;
          }

          if (isWaitingTimeSection) {
              let applicationIndex = key.match(/application_(\d+)/);
              if (applicationIndex) {
                  waitingTimeData.push({ application: applicationIndex[1], waitingTime: value });
              }
          } else {
              formData[key] = decodeURIComponent(value);
          }
      });

      setDataF(formData);
      window.importedWaitingTimeData = waitingTimeData; 

      table_obj.eliminateRows(); 
      waitingTimeData.forEach(wt => {
          table_obj.appendRow(wt.application, wt.waitingTime);
      });
  };

  reader.readAsText(file, 'UTF-8');
}


function loadWaitingTimesFromImport(data) {
  table_obj.eliminateRows(); 
  data.forEach(wt => {
      
      table_obj.appendRow(wt.application, wt.waitingTime);
  });
}

function setDataF(data) {
  
  for (let key in data) {
      if (key === "csrfmiddlewaretoken" || key === "selected-element-id") {
          continue;
      }
      if (key === "flowrate") {
        let flowrateData = [];
        try {
            let sanitizedFlowrate = data.flowrate.slice(1, -1);
            let flowrateItems = sanitizedFlowrate.split(/},\s*{/);
            
            flowrateItems.forEach(item => {
                item = `{${item.replace(/^\{/, '').replace(/\}$/, '')}}`;
                let parsedItem = JSON.parse(item);
                flowrateData.push(parsedItem);
            });
            
            if (Array.isArray(flowrateData)) {
                flowGraph.loadSegment(flowrateData);
            } else {
            }
        } catch (e) {
            console.error("Error al parsear flowrate:", e);
        }
      
      } else {
          let input = document.querySelector(`[name=${key}]`);
          if (input) {
              
              if (input.type === "checkbox") {
                  input.checked = data[key] === "True";
              } else if (input.type === "select-one" || input.type === "text" || input.type === "number") {
                  input.value = data[key];
              }
          } else {
              console.log(`Field ${key} not found in the form.`);
          }
      }
  }

  $(".change-graph-size-parameter").trigger("change");
  flowrateCalc(); 
}

document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('import_csv_button').addEventListener('click', function (e) {
      e.preventDefault();
      let file = document.getElementById('import_csv_file').files[0];
      if (file) {
          importCsv(file);
      } else {
          alert("Please select a CSV to import.");
      }
  });
});

// MAIN
function mainCalculations(){
  let plate_x_size = parseFloat($("#id_size_x").val());
  let plate_y_size = parseFloat($("#id_size_y").val());

  let offset_left_size = parseFloat($("#id_offset_left").val());
  let offset_right_size = parseFloat($("#id_offset_right").val());
  let offset_top_size = parseFloat($("#id_offset_top").val());
  let offset_bottom_size = parseFloat($("#id_offset_bottom").val());

  let volume = parseFloat($("#id_develop_volume").val());
  let printBothways = $('#printBothwaysButton').text();

  let band_height = 0.1;


  // Check if theres missing parameters
  missing_parameter = (isNaN(plate_x_size)||isNaN(plate_y_size)||isNaN(offset_left_size)||isNaN(offset_right_size)||isNaN(offset_top_size)||isNaN(offset_bottom_size)||isNaN(volume))

  if(areErrors('#id_parameter_error',missing_parameter)){return}

  // Calculate the Working Area [x,y]
  working_area = nBandsWorkingArea(plate_x_size,offset_left_size,offset_right_size,plate_y_size,offset_top_size,offset_bottom_size)

  // Check if its not posible to calculate the wa
  if(areErrors('#id_offsets_error',isNaN(working_area[0]) && isNaN(working_area[1]))){return}

  // Check if the vertical sizes is enough
  if(areErrors('#id_space_error',working_area[1]<band_height)){return}

  band_size = working_area[0]

  plotPreview.eliminateAllPoints()
  newdata = []
  newdata[0]={y:offset_bottom_size,x:offset_left_size}
  newdata[1]={y:offset_bottom_size+band_height,x:offset_left_size}
  newdata[2]={y:offset_bottom_size+band_height,x:band_size+offset_left_size}
  newdata[3]={y:offset_bottom_size,x:band_size+offset_left_size}
  newdata[4]=newdata[0]
  plotPreview.addData2Chart('1','black', newdata)
}

//Calculates the Working Area
function nBandsWorkingArea(plate_x_size,offset_left_size,offset_right_size,plate_y_size,offset_top_size,offset_bottom_size){
  working_area = [plate_x_size-offset_left_size-offset_right_size,plate_y_size-offset_top_size-offset_bottom_size]
  if(working_area[0] <= 0 || working_area[1] <= 0 || isNaN(working_area[0]) || isNaN(working_area[1])){
    return [NaN,NaN];
  }
  else{
      return working_area;
  }
}


function areErrors(error_id, bolean_exp){
  if(bolean_exp){
    $(error_id).fadeIn();
    return true
  }
  else{
    $(error_id).fadeOut();
    return false
  }
}


// Import/Export DATA
$('#downloadfilebttn').on('click', function (e) {
  e.preventDefault()
  var element = document.createElement('a');

  var plate = getFormData($('#plateform'))
  var pressure = getFormData($('#pressureform'))
  var zero = getFormData($('#zeroform'))
  var table = getSpecificFluid(false)
  
  items = Object.assign(plate,pressure,table,zero)

  content = JSON.stringify(items);
  filename = new Date().toLocaleString()+".json"

  element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(content));
  element.setAttribute('download', filename);
  element.style.display = 'none';
  document.body.appendChild(element);
  element.click();
  document.body.removeChild(element);
})
$('#loadfilebttn').on('click', function (e) {
  e.preventDefault()
  var file = $('#file')[0].files[0];
  getAsText(file);
})
$('#removefilebttn').on('click', function (e) {
  $('#file').next('.custom-file-label').html('');
  $('#file').val('')
  $('#sizesfile').html('')
})
$('#file').on('change',function(e){
                //get the file name
                var fileName = e.target.files[0];
                $(this).next('.custom-file-label').html(fileName.name);
            })

// Return form data as Object
function getFormData($form){
  var unindexed_array = $form.serializeArray();
  var indexed_array = {};

  $.map(unindexed_array, function(n, i){
      indexed_array[n['name']] = n['value'];
  });

  return indexed_array;
}

// Method that control the file load
function getAsText(readFile) {

  var reader = new FileReader();

  // Read file into memory as UTF-16
  reader.readAsText(readFile, "UTF-8");

  // Handle progress, success, and errors
  reader.onload = loaded;
  reader.onerror = errorHandler;

  function loaded(evt) {
    var fileString = evt.target.result;
    console.log(fileString);
    jsonObject = JSON.parse(fileString)
    loadMethodSuccess(jsonObject)
    console.log(jsonObject)
  }
  function errorHandler(evt) {
    if(evt.target.error.name == "NotReadableError") {
      // The file could not be read
    }
  }
}

function flowrateCalc(){
  length = $("#id_size_x").val() - $("#id_offset_left").val() - $("#id_offset_right").val();
  speed = $("#id_motor_speed").val();
  volume = $("#id_develop_volume").val();
  applications = $("#id_applications").val();
  time = length / speed;
  flowrate = Math.round(volume / time / applications, 3);
  $('#flowrate').text('estimated flowrate: ' + flowrate + " ul/s");
}

var getData = function(){
    data = $('form').serialize()+flowGraph.saveSegment(true)
    return data
}

var setData = function (data){
  $.each(data,function (key,value){
    $('input[name='+key+']').val(value)
    if(key=="printBothways"){
      if(value=="True"){
        $('input[name='+key+']').prop('checked', true);
      }
      else{
        $('input[name='+key+']').prop('checked', false);
      }
    }
    if (key=="fluid"){
      $('select[name='+key+']').val(value);
    }
  })
  flowGraph.loadSegment(data.flowrate)
  $(".change-graph-size-parameter").trigger("change")
}

var list_of_saved = new listOfSaved("http://127.0.0.1:8000/development/save/",
    "http://127.0.0.1:8000/development/list",
    "http://127.0.0.1:8000/development/load",
    getData,
    setData,
    "http://127.0.0.1:8000/development/delete"
    )

var application_control = new ApplicationControl('http://127.0.0.1:8000/oclab/control/',
                                                'http://127.0.0.1:8000/development/start/',
                                                getData)

$(document).ready(function() {
  flowrateCalc();
  list_of_saved.loadList()
});








