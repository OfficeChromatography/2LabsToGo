document.addEventListener('DOMContentLoaded', function() {
    var selectedFile;
  
    document.getElementById('import-csv-btn').addEventListener('click', function() {
        if (selectedFile) {
            var reader = new FileReader();
            reader.onload = function(e) {
                processCSV(e.target.result);
            };
            reader.readAsText(selectedFile);
        } else {
            alert("Please select a file first.");
        }
    });
  
    document.getElementById('csvFile').addEventListener('change', function(event) {
        selectedFile = event.target.files[0];
    });
});

function processCSV(csvData) {
    var lines = csvData.trim().split("\n");
    var result = {};
    var colorSelected = [];
    var defaultImageUrl = 'http://127.0.0.1:8000/static/img/login.jpg';
    lines.forEach(function(line) {
        if (line.startsWith('colorSelected')) {
            let jsonString = line.substring('colorSelected'.length).trim();
            try {
                if (!jsonString.startsWith("[")) {
                    jsonString = "[" + jsonString; 
                }
                if (!jsonString.endsWith("]")) {
                    jsonString = jsonString + "]"; 
                }

                colorSelected = JSON.parse(jsonString);
            } catch (error) {
                
                alert("Error with JSON: " + error.message);
            }
        } else {
            let firstCommaIndex = line.indexOf(',');
            let key = line.substring(0, firstCommaIndex).trim();
            let value = line.substring(firstCommaIndex + 1).trim();
            value = decodeURIComponent(value);

            result[key] = value;
        }
    });
    result['image_id'] = defaultImageUrl;

    loadDataIntoForm(result, colorSelected);
}

function loadDataIntoForm(data, colorSelected) {
    Object.keys(data).forEach(function(key) {
        if (key === "image_id") {
            var image = document.getElementById('image_id');
            if (image) {
                image.src = data[key];
                image.alt = data[key];
                } 
        } else if (key === "note") {
            var noteTextArea = document.getElementById('notestextarea');
            if (noteTextArea) {
                noteTextArea.value = data[key];
            }
        } else {
            var input = document.querySelector(`[name="${key}"]`);
            if (input) {
                input.value = data[key];
                input.dispatchEvent(new Event('change', { bubbles: true }));
            } else {
                console.warn("No input found for key:", key);
            }
        }
    });

    if (colorSelected.length > 0) {
        colorSelected.forEach(function(color) {
            var colorInput = document.querySelector(`[name="color_${color.name}"]`);
            if (colorInput) {
                colorInput.value = color.value;
                colorInput.dispatchEvent(new Event('change', { bubbles: true }));
            }
        });

        $('#picker').colpickSetColor({
            r: colorSelected.find(c => c.name === 'red').value,
            g: colorSelected.find(c => c.name === 'green').value,
            b: colorSelected.find(c => c.name === 'blue').value
        });
    }
}


// Export Button
$('#exportbttn').on('click', function (ev) {
    ev.preventDefault()
    var element = document.createElement('a');
    element.setAttribute('href', $('#image_id').attr('src'));
    element.setAttribute('download', $('#image_id').attr('name'));
    element.style.display = 'none';
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
})

// Open image in new tab when clicked
$('#image_new_tab_bttn').on('click', function (ev) {
    ev.preventDefault()
    window.open($('#image_id').attr('src'))
})

$('#delete_image').on('click', function (ev) {
    ev.preventDefault()
    id = $("#image_id").attr('alt')
    $.ajax({
      type: 'DELETE',
      url:    window.location.origin+'/capture/delete/'+ id,
      success: deleteMethodSuccess,
      error: deleteMethodError,
    });
})
function deleteMethodSuccess(id, textStatus, jqXHR){
    list_of_saved.loadList()
    console.log(list_of_saved.loadList())

}
function deleteMethodError(jqXHR, textStatus, errorThrown){console.log('error')}






