var roomName = 'oc_lab';
var chatSocket
const monitorTextArea = document.querySelector('#MonitorTextArea')
const pressureTextArea = document.querySelector('#PressureTextArea')


chatSocket = new WebSocket('ws://' + window.location.host + '/ws/monitor/' + roomName + '/');

chatSocket.onmessage = function(e) {
    var data = JSON.parse(e.data);
    data.message+='\n'
    writeOnTextBox(data.message)
    
};

chatSocket.onclose = function(e) {
    console.error('Chat socket closed unexpectedly');
};

$( document ).ready(function(){
    monitorEndpointRequest()
})

//// Send the POST request when 'Send' button is pressed
$('#chatform').on('submit', function(event){
  event.preventDefault()
  var data = {'gcode':$('#id_chattext').val()}
  $.ajax({
    method: 'POST',
    url:    window.location.origin+'/send/',
    data:   data,
    success: sendMessageSuccess,
    error: sendMessageError,
    })
    function sendMessageSuccess(data, textStatus, jqXHR){}
    function sendMessageError(jqXHR, textStatus, errorThrown){}
})

var r = null;

function writeOnTextBox(line){
    let text = monitorTextArea.value;
    monitorTextArea.value += line;
    const regexp = /\n/g;
    let newLines = [...monitorTextArea.value.matchAll(regexp)]
    let rows = monitorTextArea.rows-2
    if(newLines.length>rows){
        monitorTextArea.value = text.slice(newLines[newLines.length-rows].index,text.length)+line
    }
    else{
        monitorTextArea.value += line;
    }
    let pattern = new RegExp('(Pr: [0-9].[0-9][0-9]|Pr: [0-9][0-9].[0-9][0-9]|Pressure[psi]:)', 'g');
    var result = line.match(pattern);
    if (result == r || result == null) {
        r = r;
    } else {
        r = result;
    }
    pressureTextArea.value = r;
		

    
    // To build a file (text file in this case), generate an URL and make click on it
    const saveTextPlain = (cntent, name) => {
        const a = document.createElement("a");
        const txtfile = new Blob([cntent], { type: 'text/plain' });
        const url = URL.createObjectURL(txtfile);
        a.href = url;
        a.download = name;
        a.click();
        URL.revokeObjectURL(url);
    }
    const $downloadButton = document.querySelector("#download");
    $downloadButton.onclick = () => {
        saveTextPlain(text , "lastgcode.txt");
    }


    $("#MonitorTextArea").scrollTop($("#MonitorTextArea").prop('scrollHeight'))

}


//// If theres a current connection with the OC then loads the previous chats
function monitorEndpointRequest(){
    connectionInfo = window.location.origin + '/connection_info/'
    $.ajax({
        method: 'GET',
        url:    connectionInfo,
        success: connectionInfoEndpointSucess,
        error: connectionInfoEndpointError,
    })
    function connectionInfoEndpointSucess(data, textStatus, jqXHR){
        writeOnTextBox(data.message)
        console.log(data)
        if(data.connected){
            $('#id_device_info').text(data.port)
            $('#id_baudrate_info').text(data.baudrate)
        }
        else{
            $('#id_device_info').text("")
            $('#id_baudrate_info').text("")
        } 
    }
    function connectionInfoEndpointError(jqXHR, textStatus, errorThrown){}
}