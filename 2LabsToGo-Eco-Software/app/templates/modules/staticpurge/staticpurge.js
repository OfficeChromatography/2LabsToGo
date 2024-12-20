$('#pump_manual').on('click',function(e){
  e.preventDefault();
    console.log($("#static-form").serialize());
    $.ajax({
    method: 'POST',
    url:    window.location.origin+'/staticpurge/',
    data:   $("#static-form").serialize(),
    success: staticCleanMethodSuccess,
    error: staticCleanMethodError,
    })
    function staticCleanMethodSuccess(data, textStatus, jqXHR){
    }
    function staticCleanMethodError(jqXHR, textStatus, errorThrown){}
  }
)

$("#next_bttn_stat").on('click',function(e){
  $.when($("#staticpurgecard").fadeOut()).done(function() {
         $("#stepscounter").text('Step 2/3')
         $("#dinamicpurgecard").fadeIn();
         $("#next_bttn_stat").hide()
  });
})
