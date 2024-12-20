const monitor = document.querySelector('#monitor_text_log')
function loadMonitor(id){
  $.ajax({
    method: 'GET',
    url:    window.location.origin+'/monitor/'+id+'/',
    success: loadMonitorSuccess,
    error: loadMonitorError,
  })
  function loadMonitorSuccess(data, textStatus, jqXHR){
  console.log(data)
    monitor.value=data.monitortext
  }
  function loadMonitorError(jqXHR, textStatus, errorThrown){}
}
