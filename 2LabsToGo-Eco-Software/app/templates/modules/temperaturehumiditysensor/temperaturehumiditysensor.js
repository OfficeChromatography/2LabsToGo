var roomName = 'air_sensor';
var chatSocket = new WebSocket('ws://' + window.location.host + '/ws/monitor/' + roomName + '/');

chatSocket.onmessage = function(e) {
    var data = JSON.parse(e.data);
    $("#air_sensor_module").show()
    if(data.message!=undefined && data.message.temperature!="0.00" && data.message.humidity!="0.00"){
        $("#air_temperature").text(data.message.temperature+"°C")
        $("#air_humidity").text(data.message.humidity+"%")
    }
    else{
        $("#air_sensor_module").hide()
    }
};

chatSocket.onclose = function(e) {
    $("#air_sensor_module").hide()
};

getAirSensor = () => {
    $.post( window.location.origin+'/send/',{gcode:"G96"})
}

$("#air_sensor_sync").on("click", getAirSensor)
