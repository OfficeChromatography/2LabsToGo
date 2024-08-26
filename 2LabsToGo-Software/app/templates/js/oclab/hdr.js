$( document ).ready(function(){
  loadlistofimages()
  $('#list-of-images').multiSelect()
})

// Select and unselect functions
$('#list-of-images').multiSelect({
  afterSelect: function(values){
    getImages(values)
    console.log(values)
  },
  afterDeselect: function(values){
    // eliminate images
    $("#card-"+values[0]).remove()
  }
});
function getImages(values){
  data = {'id':values[0], 'LOADFILE':''}
  $.ajax({
    method: 'GET',
    url:    window.location.origin+'/capture/',
    data:   data,
    success: loadfileMethodSuccess,
    error: loadfileMethodError,
  })
  function loadfileMethodSuccess(data, textStatus, jqXHR){
  console.log(data)
    text=`<table><tr><th>Property</th><th>Value</th></tr>`
    $.each( data.meta, function( key, value ) {
      text+= `<tr><td><b>`+key+`</b></td><td>`+value+`</td></tr>`
    });
//    text+=</table>
    $('.card-columns').append(`<div class="card" id="card-`+data.id+`">
      <img class="card-img-top" src="`+data.url+`" alt="`+data.id+`">
      <div class="card-body">
        <h5 class="card-title">`+data.filename+`</h5>
        <p class="card-text">`+text+`</p>
      </div>
    </div>`)
  }
  function loadfileMethodError(jqXHR, textStatus, errorThrown){}
}
// Get the list of images
function loadlistofimages(){
  $.ajax({
    method: 'GET',
    url:    window.location.origin+'/capture/',
    data:   '&LISTLOAD',
    success: loadlistMethodSuccess,
    error: loadlistMethodError,
  })
  function loadlistMethodSuccess(data, textStatus, jqXHR){
  console.log(data)
    var i = 0;
    $.each(data, function(key, value) {
        $('#list-of-images').multiSelect('addOption', { value: value[1], text: value[0]});
        i++;
      })
    return
  }
  function loadlistMethodError(jqXHR, textStatus, errorThrown){}
}
//  Process images
$('#processbttn').on('click',function(e){
  e.preventDefault()
  $endpoint = window.location.origin+'/hdr/'
  $formData ={  AligmentConfigurationForm:$('#AligmentConfigurationForm').serialize(),
                id:new Array()}
  i=0;
  $('.card-img-top').each(function(){
      $formData.id.push($(this).attr('alt'))
      });
  $.ajax({
    method: 'POST',
    url:    $endpoint,
    data:   $formData,
    success: processMethodSuccess,
    error: processMethodError,
    })
    function processMethodSuccess(data, textStatus, jqXHR){
      //Hide the images selected.
      $('.card-columns').children().fadeOut("slow",function(){
        $('#list-of-images').multiSelect('deselect_all')
        $('.card-columns').empty()
        $('.card-columns').append(`<div class="card" id='card-`+'Result:'+`'>
          <img class="card-img-top" src="`+data.url+`" alt="Card image cap">
          <div class="card-body">
            <h5 class="card-title">`+data.method+`</h5>
            <p class="card-text">`+'Result'+`</p>
          </div>
        </div>`)
      });
      $('#options-card').fadeOut( 800 )
      // Show the new image
    }
    function processMethodError(jqXHR, textStatus, errorThrown){
        $('#id_error_alert_hdr').text(jqXHR.responseText)
        $( "#id_error_alert_hdr" ).fadeIn().delay( 800 ).fadeOut( 400 );
        eliminateAllCards()
    }
})


function eliminateAllCards(){
    $('#list-of-images').multiSelect('deselect_all')
    $('.card-columns').empty()
}

// $('#processbttn').on('click', function (e) {
//   event.preventDefault()
//   $formData =
//   $endpoint = window.location.origin+'/capture/'
//   $.ajax({
//   method: 'POST',
//   url:    $endpoint,
//   data:   $formData,
//   success: shootMethodSuccess,
//   error: shootMethodError,
//   })
// })
// function shootMethodSuccess(data, textStatus, jqXHR){
//   $("#image_id").attr("src",data.url);
// }
// function shootMethodError(jqXHR, textStatus, errorThrown){}
