$('#pump_manual').on('click',function(e){
  e.preventDefault();
    console.log($("#static-form").serialize());
    $.ajax({
    method: 'POST',
    url:    window.location.origin+'/staticpurgeas/',
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
  $.when($("#staticpurgeascard").fadeOut()).done(function() {
         $("#stepscounter").text('Step 2/3')
         $("#dinamicpurgeascard").fadeIn();
         $("#next_bttn_stat").hide()
  });
})
