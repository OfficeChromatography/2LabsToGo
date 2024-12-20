$('#notesModal').on('shown.bs.modal', function (e) {
  e.preventDefault()
  var imageId = $('#image_id').attr('alt');
  $.ajax({
      method: 'GET',
      url: captureEndpoint,
      data: {
          'action': 'LOAD_NOTE',
          'id': imageId
      },
      success: loadNoteMethodSuccess,
      error: loadNoteMethodError,
  })
})

$('#save_note_bttn').on('click', function (e) {
  e.preventDefault()
  var imageId = $('#image_id').attr('alt');
  var noteText = $('#notestextarea').val();
  $.ajax({
      method: 'POST',
      url: captureEndpoint,
      data: {
          'action': 'SAVE_NOTE',
          'id': imageId,
          'note': noteText
      },
      success: saveNoteMethodSuccess,
      error: saveNoteMethodError,
  })
})

function saveNoteMethodSuccess(data, textStatus, jqXHR){
  $('#notesModal').modal('hide');
  console.log("Note saved successfully");
}

function saveNoteMethodError(jqXHR, textStatus, errorThrown){
  console.log("Error saving note");
}

function loadNoteMethodSuccess(data, textStatus, jqXHR){
  $('#notestextarea').val(data.note);
}

function loadNoteMethodError(jqXHR, textStatus, errorThrown){
  console.log("Error loading note");
}
