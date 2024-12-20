$("#warming_up").on('click',function(e){
    e.preventDefault();
    console.log($("#warmup-form").serialize());
    $.ajax({
    method: 'POST',
    url:    window.location.origin+'/warmupas/',
    data:   $("#warmup-form").serialize(),
    success: staticCleanMethodSuccess,
    error: staticCleanMethodError,
    })
    function staticCleanMethodSuccess(data, textStatus, jqXHR){
    }
    function staticCleanMethodError(jqXHR, textStatus, errorThrown){}
    })

$("#warmup-form").on('keydown',function(event){
    console.log(event.which)
    if(event.which == 13) $('#warming_up').click()
    })

$('#warmupAsModal').on('shown.bs.modal', function (e) {
    sendToMachine('G0X1');
})