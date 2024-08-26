function sendToMachine(value) {
    var data = {'gcode': value};
    console.log(data);
    $.ajax({
        method: 'POST',
        url: window.location.origin + '/send/',
        data: data,
        success: setHommingEndpointSuccess,
        error: setHommingEndpointError,
    });
}

function setHommingEndpointSuccess(data, textStatus, jqXHR) {
    console.log("Success!");
}

function setHommingEndpointError(jqXHR, textStatus, errorThrown) {
    console.log(errorThrown);
}

// Funktion zum Steuern der Pumpe mit einer bestimmten Anzahl von Vorgängen
async function controlPump(cycles) {
    for (let i = 0; i < cycles; i++) {
        sendToMachine('M42 P40 S255'); // Pumpe ansaugen
        sendToMachine('M400');
        sendToMachine('M42 P40 S0');   // Pumpe pumpen
        sendToMachine('M400');
        // await new Promise(resolve => setTimeout(resolve, 1000)); // 1 Sekunde warten (falls nötig)
    }
}

// Event-Listener für das Formular
document.getElementById('pumpControlForm').addEventListener('submit', function(event){
    event.preventDefault();
    var cycles = document.getElementById('pumpCycles').value;  // Wert aus dem Nummernfeld holen
    controlPump(cycles);
});

// Synchronisation zwischen Range-Input und Number-Input
document.getElementById('pumpRange').addEventListener('input', function() {
    document.getElementById('pumpCycles').value = this.value;
});

document.getElementById('pumpCycles').addEventListener('input', function() {
    document.getElementById('pumpRange').value = this.value;
});

// Beispiel Callback-Funktionen für AJAX-Erfolg und -Fehler
function setHommingEndpointSuccess(response) {
    console.log('Success:', response);
}

function setHommingEndpointError(error) {
    console.error('Error:', error);
}