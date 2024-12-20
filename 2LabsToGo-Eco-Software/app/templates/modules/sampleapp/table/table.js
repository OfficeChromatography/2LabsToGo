const OPTIONS = ["Water", "Methanol", "Ethanol", "iso-Propanol", "2-Butanol", "Acetone", "Ethyl acetate"]

let tot_time = 0
let checkbox = 1

const p = document.getElementById("total-time")
//p.innerText = "Calculating estimated time..."

class Table {
    row = [];

    constructor(number_of_rows, calculationMethod) {
        this.numberOfRows = 0;
        this.calculationMethod = calculationMethod;
        this.#addMultipleRows(number_of_rows);
    }

    destructor() {
        for (let i = this.numberOfRows - 1; i >= 0; i--) {
            this.row[i].eliminate()
            this.row.pop()
            this.numberOfRows--;
        }
    }

    #addRow() {
        /**
         * Appends a row at the end of #tbody-band
         * @param  {void}
         * @return  {Object<tr.band-row>}
         */
        this.numberOfRows = this.row.push(new Table.#Row(this.calculationMethod))
        return this.row[this.numberOfRows - 1];
    }

    #addMultipleRows(n) {
        /**
         * Create n number of rows
         * @param  {number}
         * @return  {void}
         */
        for (let i = 1; i <= n; i++) {
            let newRow = this.#addRow();
            newRow.setBandNumber(this.numberOfRows)
        }
    }

    getRowByNumber(numberOfRow) {
        /**
         * Returns the row object selected by number of row
         * @param  {Number}
         * @return  {Object<tr.band-row>}
         */
        let row = $('.band-number').filter(function () {
            return this.innerHTML == numberOfRow
        }).parent();
        return row
    }

    getTableValues() {
        let data = [];
        if (this.numberOfRows == 0) {
            console.log("Empty table")
            return [];
        }
        else {
            this.row.forEach(function (value) {
                data.push(value.getRowData())
            })
        }
        console.log(data)
        return data
    }

    setTableCalculationValues(data) {
        data.forEach((row, index) => {
            this.row[index].setCalculatedData(row)
        })
        console.log(data)
        
    }

    loadTable(data) {
        console.log("Loading table with data:", data);
        // Ensure we have the correct number of rows
        if (data.length > this.numberOfRows) {
            this.#addMultipleRows(data.length - this.numberOfRows);
        } else if (data.length < this.numberOfRows) {
            this.destructor();
            this.#addMultipleRows(data.length);
        }
        data.forEach((rowData, index) => {
            if (this.row[index]) {
                this.row[index].loadDataInRow(rowData);
            } else {
                console.warn(`No row found for index ${index}`);
            }
        });
        console.log("Table loaded");    
        
    }

    estim_time(data) {
        if (data != 0) {
            //p.innerText = "       Estimated time for application : " + data[0].total_time.toFixed(3) + "min"
        }

    }

    static #Row = class Row {
        row = null;

        constructor(calculationMethod) {
            this.row = $(".band-row").first().clone().show().appendTo("#tbody-band");
            this.solventOptions = OPTIONS;
            this.#setSolventOptions();
            this.calculationMethod = calculationMethod
            this.setCalculateMethod();


        }

        setCalculateMethod() {
            this.row.find('.volume, .solvent_select').on("change", this.calculationMethod)
        }

        setEstimatedVolume(value) {
            this.row.find('.estimated-volume').text(value.toFixed(3))
        }

        getEstimatedVolume() {
            let value = this.row.find('.estimated-volume').text()
            return this.#sanityUndefined(value)
        }

        setEstimatedDropVolume(value) {
            this.row.find('.estimated-drop').text(value.toFixed(3))
        }
        getEstimatedDropVolume() {
            let value = this.row.find('.estimated-drop').text()
            return this.#sanityUndefined(value)
        }


        setMinimumVolume(value) {
            this.row.find('.minimum-volume').text(value.toFixed(3))
        }
        getMinimumVolume() {
            let value = this.row.find('.minimum-volume').text()
            return this.#sanityUndefined(value)
        }



        setTotalvolume(value) {
            console.log("setTotalvolume")
            this.row.find('.total-volume').text(value.toFixed(3))
        }
        getTotalvolume() {
            let value = this.row.find('.total-volume').text()
            return this.#sanityUndefined(value)
        }

        setSolventOption(value) {
            this.row.find('.solvent_select').val(value)
        }
        getSolventOption() {
            let value = this.row.find('.solvent_select').val()
            return this.#sanityUndefined(value)
        }
        setSample(value) {
            this.row.find('.i_sample').val(value)
        }
        getSample() {
            let value = this.row.find('.i_sample').val()
            return this.#sanityUndefined(value)
        }
        getOption() {
            let value = checkbox;
            return this.#sanityUndefined(value)
        }
        setOption(value){
            this.row.find('.checkbox').val(value)
        }

        setProduct(value) {
            console.log(`Setting product: ${value}`);
            this.row.find('.product').val(value)
        }
        getProduct() {
            let value = this.row.find('.product').val()
            return this.#sanityUndefined(value)
        }

        

        setVolumeValue(value) {
            this.row.find('.volume').val(value)
        }
        getVolumeValue() {
            let value = this.row.find('.volume').val()
            return this.#sanityUndefined(value)
        }

        setBandNumber(value) {
            console.log(`Setting band number: ${value}`);
            this.row.find('.band-number').text(value)
        }
        getBandNumber() {
            let value = this.row.find('.band-number').text()
            return this.#sanityUndefined(value)
        }

        setViscosity(value) {
            this.row.find('.viscosity').text(value)
        }
        getViscosity() {
            let value = this.row.find('.viscosity').text()
            return this.#sanityUndefined(value)
        }

        setDensity(value) {
            this.row.find('.density').text(value)
        }
        getDensity() {
            let value = this.row.find('.density').text()
            return this.#sanityUndefined(value)
        }



        #setSolventOptions() {
            /**
             * adds the solvents options to a cell
             * @param  {Object<tr.band-row> , options list}
             * @return  {void}
             */
            for (let option in this.solventOptions) {
                let aux = this.row.find('option:first')
                aux.clone()
                    .show()
                    .attr("value", this.solventOptions[option])
                    .text(this.solventOptions[option])
                    .appendTo(aux.parent())
            }
            this.row.find('select').val(this.solventOptions[0])
            this.row.find('select').on("change", function () {
                if ($(this).val() == "Specific") {
                    $(this).closest('.band-row').find('.specific-options').fadeIn()
                }
                else {
                    $(this).closest('.band-row').find('.specific-options').fadeOut()
                }
            })
        }

        #sanityUndefined(value) {
            if (value == undefined) {
                value = "";
            }
            return value;
        }

        getRowData() {

            let data = {

                "band_number": this.getBandNumber(),
                "sample": this.getSample(),
                "sample_option": checkbox,
                "product_name": this.getProduct(),
                "volume": this.getVolumeValue(),
                "type": this.getSolventOption(),
                "density": this.getDensity(),
                "viscosity": this.getViscosity(),
                "estimated_volume": this.getEstimatedVolume(),
                "estimated_drop_volume": this.getEstimatedDropVolume(),
                "minimum_volume": this.getMinimumVolume()

                }
                
            return data
        }

        setCalculatedData(data) {
            this.setEstimatedDropVolume(data.estimated_drop_volume)
            this.setMinimumVolume(data.minimum_volume)
            this.setEstimatedVolume(data.estimated_volume)
            
        }

        loadDataInRow(data) {
            console.log("Loading data into row:", data);
            for (let key in data) {
                if (data.hasOwnProperty(key)) {
                    let input = this.row.find(`[name=${key}]`);
                    if (input.is("select")) {
                        input.val(data[key]).trigger('change');
                    } else {
                        input.val(data[key]);
                    }
                }
            }
            console.log("Data loaded into row");
        }

        

        loadDataInRow(data) {
            console.log("Loading data into row:", data);
        
            for (let key in data) {
                if (data.hasOwnProperty(key)) {
                    let input = this.row.find(`[name="${key}"]`);
                    if (input.length) { 
                        if (input.is("select")) {
                            input.val(data[key]).trigger('change'); 
                        } else {
                            input.val(data[key]); 
                        }
                    } else {
                        console.warn(`No input found for key: ${key}`);
                    }
                }
            }
        
            this.setBandNumber(data.band_number);
            this.setProduct(data.product_name);
            this.setSample(data.sample);
            this.setVolumeValue(data.volume);
            this.setSolventOption(data.type);
            this.setDensity(data.density);
            this.setViscosity(data.viscosity);
            this.setOption(checkbox);
        
            this.row.find('.volume').trigger('change');
            this.row.find('.solvent_select').trigger('change');
        
            console.log("Data loaded into row");
        }
        

        eliminate() {
            this.row.remove();
        }
    }
}

$('.product').change(function () {
    console.log($('.product').val())
})


var productName = "Product Name"


$(document).on('click', '.copybttn', function () {
    
    productName = $(this).parent().find(".product").val()
    
    console.log(productName) 
});

$(document).on('click', '.pastebttn', function () {
    
    $(this).parent().find(".product").val(productName)
    
});

$(document).ready(function () {
    
});