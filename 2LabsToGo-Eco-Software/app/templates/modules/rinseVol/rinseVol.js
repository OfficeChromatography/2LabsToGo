

$("#pump_manual").on('click',function(e){
    e.preventDefault();
    console.log($("#rinse-form").serialize());
    $.ajax({
    method: 'POST',
    url:    window.location.origin+'/staticpurge/',
    data:   $("#rinse-form").serialize(),
    success: staticCleanMethodSuccess,
    error: staticCleanMethodError,
    })
    function staticCleanMethodSuccess(data, textStatus, jqXHR){
    }
    function staticCleanMethodError(jqXHR, textStatus, errorThrown){}
    })

$("#rinse-form").on('keydown',function(event){
    console.log(event.which)
    if(event.which == 13) $('#pump_manual').click()
    })

$("#valveToggle").on('click',function(e){
    e.preventDefault();
    console.log("Toggle button clicked. Current text: " + $("#toggleText").html());
    if ($("#toggleText").html() == "Open Valve"){
        console.log("Entering Open Valve");
        $("#toggleText").html("Close Valve");
        sendToMachine('G41');
        console.log("valve opened");
    } else {
        console.log("Entering Close Valve");
        $("#toggleText").html("Open Valve");
        sendToMachine('G40');
        console.log("valve closed");
    }
})

$('#rinseVolModal').on('shown.bs.modal', function (e) {
    sendToMachine('G0X1');
})
