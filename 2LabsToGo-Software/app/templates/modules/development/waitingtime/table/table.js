class TableWaitingTime {
    constructor(importedData = null) {
        this.table = $('#waitingTimeTable');
        this.row_template = $('#row_wait_template');
        this.numberOfApplications = parseInt($("input[name='applications']").val());
        this.development_id = $('#selected-element-id').val();

        if (importedData) {
            this.loadFromImport(importedData); 
        } else if (this.development_id) {
            this.loadFromServer();
        } else {
            this.notInServer();
        }
    }

    notInServer(){
        this.eliminateRows();
        for(let i = 1; i <= this.numberOfApplications; i++){
            this.appendRow(i, 3);
        }
    }

    eliminateRows(){
        $('.row_waiting_time').remove();
    }

    appendRow(id, value){
        let new_row = this.row_template.clone()
            .attr("id","row_waiting_time_" + id)
            .addClass("row_waiting_time");
        let input = new_row.find('input');
        let input_name = id;

        new_row.find('.id_application').text(id);
        input.attr('name', input_name);
        input.val(value);

        this.table.append(new_row);
        new_row.show();
    }

    loadFromServer() {
        let table = this;

        if (!this.development_id || this.development_id === '') {
            this.notInServer();
            return;
        }

        $.get(window.location.origin + '/development/waiting_time/' + this.development_id + "/")
            .done(function(data){
                if (data.length > 0) {
                    table.eliminateRows();
                    data.forEach(function(item){
                        table.appendRow(item.application, item.waitTime);
                    });
                } else {
                    table.notInServer();
                }
            })
            .fail(function(){
                table.notInServer();
            });
    }

    loadFromImport(importedData) {
        this.eliminateRows();
        importedData.forEach(wt => {
            this.appendRow(wt.application, wt.waitingTime);
        });
        
    }

    saveOnServer(){
        let table = this;
        let data = {};
        data.waitingTimes = table.getValues();
        
        if(this.development_id !== ''){
            data.development_id = this.development_id;
        } else {
            console.error("No development_id found.");
            return;  
        }
    
    
        $.ajax({
            url: window.location.origin + '/development/waiting_time/',
            type: 'POST',
            data: JSON.stringify(data),  
            contentType: 'application/json; charset=utf-8',  
            dataType: 'json',  
            success: function(response){
                
                table.loadFromServer();  
            },
            error: function(error){
                console.error("Error saving on server:", error);
                alert("Error saving data: " + error.responseText);
            }
        });
    }
    
    getValues = () => {
        let values = $('.row_waiting_time input');
        let waitingTimes = [];
        values.each(function (){
            let waitingTime = {};
            waitingTime['application'] = $(this).attr("name");
            waitingTime['waitingTime'] = $(this).val();
            waitingTimes.push(waitingTime);
        });
        console.log("getting values:", waitingTimes);
        return waitingTimes;
    }
}


