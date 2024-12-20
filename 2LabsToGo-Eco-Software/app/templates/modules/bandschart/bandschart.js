// Graph var
var ctx = document.getElementById('plotPreview').getContext('2d');
var plotPreview = new Chart(ctx, {
    type: 'scatter',
    data: {
        datasets: [{
            borderColor: 'black',
            backgroundColor: 'transparent',
            borderWidth: 1,
            pointBackgroundColor: ['#000', '#000', '#000'],
            pointRadius: 1,
            pointHoverRadius: 1,
            fill: false,
            tension: 0,
            showLine: true,
        },]
    },
    options:{
        legend:{
            display:false
        },
        scales: {
            yAxes: [{
                stacked: true,
                ticks: {
                    min: 0, // minimum value
                    max: 100, // maximum value
                    reverse: true,
                },
            }],
            xAxes: [{
                stacked: true,
                ticks: {
                    min: 0, // minimum value
                    max: 100, // maximum value
                },
            }]

        }
    },
});

// add new bands to the chart
plotPreview.addData2Chart = function addData2Chart(label, color, data) {
    plotPreview.data.datasets.push({
        label: label,
        backgroundColor: color,
        data: data,
        borderColor: 'black',
        borderWidth: 1,
        pointRadius: 2,
        pointHoverRadius: 4,
        fill: true,
        tension: 0,
        showLine: true,
    });
    plotPreview.update();
}

plotPreview.eliminateAllPoints = function (){
    while(plotPreview.data.datasets.pop()!=undefined){}
}

plotPreview.changeGraphSize = function (){
    plotPreview.config.options.scales.xAxes[0].ticks.max = parseFloat($("#id_size_x").val());
    plotPreview.config.options.scales.yAxes[0].ticks.max = parseFloat($("#id_size_y").val());
    plotPreview.update();
}
