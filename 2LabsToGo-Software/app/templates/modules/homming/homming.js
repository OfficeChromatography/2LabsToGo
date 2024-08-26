$('#hommingModal').on('shown.bs.modal', function (e) {
  gcode = 'G28XY\nG91';
  sendToMachine(gcode);
  zero_position = [0, 0];
});

$('#hommingModal').on('hidden.bs.modal', function (e) {
  gcode = 'G90';
  sendToMachine(gcode);
  zero_position = [0, 0];
});

