jQuery(document).ready(function () {
  get_username()
})

function get_username() {
  $.getJSON('/userinfo', function (data, textStatus, jqXHR){
      document.getElementById('username').innerHTML=data.username
      if(data.username==''){
        window.location.href = 'login'
      }
  });
};
