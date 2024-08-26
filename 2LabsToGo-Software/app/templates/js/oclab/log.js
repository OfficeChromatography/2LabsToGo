var t = $('#dataTable').DataTable();
var i = 0
t.on( 'draw.dt', function () {
    addEventForMonitorClick()
} );

monitor_icon = $('<i class="fas fa-desktop"></i>')


$(document).ready( function () {
    loadlistofgcodes()
} );

function loadlistofgcodes(){
  $.ajax({
    method: 'GET',
    url:    window.location.origin+'/logdatatable/',
    data:   '&LISTLOAD',
    success: loadlistMethodSuccess,
    error: loadlistMethodError,
  })
  function loadlistMethodSuccess(data, textStatus, jqXHR){
    
    $.each(data, function(key, value) {
      t.row.add([
        value.auth_id,
        value.oc_lab,
        value.baudrate,
        value.timeout,
        value.time_of_connection,
        "<i id='"+value.id+"' class='fas fa-desktop'></i>"
      ]).draw(false)
      addEventForMonitorClick()
    })
    return
  }
  function loadlistMethodError(jqXHR, textStatus, errorThrown){}
}

function addEventForMonitorClick(){
    $(document).find('.fa-desktop').on('click',(event)=>{
        event.stopPropagation();
        event.stopImmediatePropagation();
        loadMonitor(event.target.id)
        $('#monitorModal').modal('show')
    })
}




