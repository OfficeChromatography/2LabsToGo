$(document).ready(function(){
  isConnectedEndpointRequest()
})

// Check if theres a current connection with the OC
function isConnectedEndpointRequest(){
  monitorendpoint = window.location.origin + '/isconnected/'
  $.ajax({
    method: 'GET',
    url:    monitorendpoint,
    success: isConnectedEndpointSucess,
    error: isConnectedEndpointError,
  })
}
function isConnectedEndpointSucess(data, textStatus, jqXHR){
  if(data['connected']==true){
    
    monitorEndpointRequest();
  }
  else{
    console.log('not connected');
  }
}
function isConnectedEndpointError(jqXHR, textStatus, errorThrown){}
