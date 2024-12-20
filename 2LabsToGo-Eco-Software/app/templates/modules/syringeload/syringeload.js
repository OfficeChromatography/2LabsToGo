$(document).ready(function() {
  loadlistofvolumes();
  bindUIEvents();
});

function loadlistofvolumes() {
  $.ajax({
    method: 'GET',
    url: window.location.origin + '/syringeload/',
    data: '&LISTLOAD',
    success: loadlistMethodSuccess,
    error: loadlistMethodError,
  });
}

function loadlistMethodSuccess(data, textStatus, jqXHR) {
  $('#list_syringe_vol').empty();
  $.each(data, function(key, value) {
    $('#list_syringe_vol').append(
      `<a class="list-group-item list-group-item-action py-1 volume-list" id="${value}" data-toggle="list" href="#list-home" role="tab" aria-controls="home">${value}</a>`
    );
  });
  $('#list-load a:first-child').click();
}

function loadlistMethodError(jqXHR, textStatus, errorThrown) {
  console.error('Error loading syringe volumes:', textStatus, errorThrown);
}

function bindUIEvents() {
  $(document).on('click', '.volume-list', function(e) {
    e.preventDefault();
    $("#syringe_volume").val($(this).attr('id'));
    console.log($(this).attr('id'));
  });

  $("#moveSyringeMotor").on("click", function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: window.location.origin + '/syringeload/',
      data: '&MOVEMOTOR=' + $("#syringe_volume").val(),
      success: moveSyringeMotorSuccess,
      error: moveSyringeMotorError,
    });
  });

  $("#syringe_volume").on('keydown', function(event) {
    console.log(event.which);
    if (event.which == 13) $('#moveSyringeMotor').click();
  });

  $("#save_syringe_volume").on("click", function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: window.location.origin + '/syringeload/',
      data: '&SAVEMOVEMOTOR=' + $("#syringe_volume").val(),
      success: saveSyringeMotorSuccess,
      error: saveSyringeMotorError,
    });
  });

  $("#delete_syringe_volume").on("click", function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: window.location.origin + '/syringeload/',
      data: '&DELETE=' + $(".volume-list.active").attr('id'),
      success: deleteSyringeMotorSuccess,
      error: deleteSyringeMotorError,
    });
  });

  $('#syringeModal').on('shown.bs.modal', function(e) {
    sendToMachine('M92Z1600');
    sendToMachine('M203Z5');
    sendToMachine('M42P49S255');
    sendToMachine('M42P36S255');
    sendToMachine('G90');
    sendToMachine('G28Z');
  });
}

function moveSyringeMotorSuccess(data, textStatus, jqXHR) {
}

function moveSyringeMotorError(jqXHR, textStatus, errorThrown) {
  console.error('Error moving syringe motor:', textStatus, errorThrown);
}

function saveSyringeMotorSuccess(data, textStatus, jqXHR) {
  loadlistofvolumes();
}

function saveSyringeMotorError(jqXHR, textStatus, errorThrown) {
  console.error('Error saving syringe volume:', textStatus, errorThrown);
}

function deleteSyringeMotorSuccess(data, textStatus, jqXHR) {
  loadlistofvolumes();
}

function deleteSyringeMotorError(jqXHR, textStatus, errorThrown) {
  console.error('Error deleting syringe volume:', textStatus, errorThrown);
}
