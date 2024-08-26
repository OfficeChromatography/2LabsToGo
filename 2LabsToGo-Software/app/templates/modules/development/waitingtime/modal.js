var table_obj;

$('#modalwaitingtimes').on('show.bs.modal', function (e) {
    $('#waiting-time-modal-body').load(window.location.origin + '/development/waiting_time_view/', function () {
        if (window.importedWaitingTimeData && window.importedWaitingTimeData.length > 0) {
            table_obj = new TableWaitingTime(window.importedWaitingTimeData); 
            window.importedWaitingTimeData = null; 
        } else {
            table_obj = new TableWaitingTime(); 
        }
    });
});

$('#modalwaitingtimes').on('hide.bs.modal', function (e) {
    if (!window.importedWaitingTimeData) {
        table_obj.saveOnServer();
    }
});
