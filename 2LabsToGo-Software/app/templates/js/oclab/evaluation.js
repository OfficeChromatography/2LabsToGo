var list_of_saved = new listOfSaved("http://127.0.0.1:8000/evaluation/save/",
"http://127.0.0.1:8000/evaluation/list",
"http://127.0.0.1:8000/evaluation/load",
getData,
setData,
"http://127.0.0.1:8000/evaluation/deleteall"
);
  
function getData(){
    return {}
};

function setData(data){
    getBandSetup()
    id_list = data.id_list
    console.log(id_list)
    url = data.url
    $(".show-image").empty()
    if (id_list != undefined ){
        length = id_list.length
        width = 100 / length
        for (var i=0; i<length; i++) {
            console.log(url[i])
            $(".show-image").append('<img id="'+id_list[i]+'" src='+url[i]+' onclick="selectImage('+id_list[i]+',['+id_list+']);"  style="width:'+width+'%">')
        }
    }
};

function getBandSetup(){ 
    methodID= $('[aria-selected="true"]').find("a").attr("value_saved")
    $.get(window.location.origin+'/evaluation/bandsetup/'+methodID+"/").done(function (data){
        if (data.main_property == 1){
            number_of_tracks = parseInt(data.value)
            track_width = ((data.size_x - data.offset_left - data.offset_right ) - ((number_of_tracks - 1) * data.gap) ) /number_of_tracks
        } else {
            track_width = parseFloat(data.value)
            number_of_tracks = Math.trunc((data.size_x - data.offset_left - data.offset_right )/(track_width+parseFloat(data.gap)))
        }
        bands_start = parseInt(data.offset_left)
        console.log([number_of_tracks, track_width, bands_start])


        $('#id_tracks').val(number_of_tracks)
        setTracksOption()
        $('#id_trackwidth').val(track_width)
        $('#id_bandstart').val(bands_start)
    })
};

// on change --------------------------------------------------------------

$('#id_tracks').change(setTracksOption)

function setTracksOption(){
    tracks = $('#id_tracks').val()
    $('#id_tracknumber').find('option').remove().end()
    for (i = 1; i <= tracks; i++) {
        string = '<option value="'+i+'">'+i+'</option>'
        $('#id_tracknumber').append(string)
      }
}

$('#id_tracknumber').change(function(){
    string = $('#trackinspectID').attr("src").slice(0,-5)+$('#id_tracknumber').val()+".png"
    $('#trackinspectID').attr("src",string)
    string2 = $('#trackinspectRgbID').attr("src").slice(0,-5)+$('#id_tracknumber').val()+".png"
    $('#trackinspectRgbID').attr("src",string2)
    console.log($('#trackinspectID').attr("src"))
})

$('#id_rf').change(loadWhichTabIsSelected)

$('.chromoption').change(postChromatogram)

// var post = false
// $('.trackOption').change(function(){
//     post = true
//     console.log(post)
// }
// )

// ----------------------------------------------------------------------------

function selectImage(imageID, idList){


    length = idList.length
    width = 100 / length
    zoom = 1.4
    if (length>1){
        for (var i=0; i<length; i++) {
            if (imageID == idList[i]) {
                string = "width:" + width*zoom + "%"
                $("#"+imageID).attr("style",string)
                document.getElementById(imageID).style.border = "thick solid #5cb85c";
            } else {
                newWidth = (100 - width*zoom) / (length - 1)
                string = "width:" + newWidth + "%"
                $("#"+idList[i]).attr("style",string)
            }
        }
    } else {
        document.getElementById(imageID).style.border = "thick solid #5cb85c";
    }
    
    postTrackdetection(imageID)
};

function loadTrackdetection(imageID){
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/trackdetection/'+imageID+'/',
        success: onSuccess,
        error: postTrackdetection,
        })
        function onSuccess(data, textStatus, jqXHR){
            console.log(data)
            $('#evaluationcard').attr("trackdetectionID", data.data.image)
            loadWhichTabIsSelected()
        }
}

function postTrackdetection(imageID){

    number_of_tracks = $('#id_tracks').val()
    track_width = $('#id_trackwidth').val()
    bands_start = $('#id_bandstart').val()

    data = "image="+imageID+"&number_of_tracks="+number_of_tracks+"&track_width="+track_width+
        "&bands_start="+bands_start+"&front=10"
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/trackdetection/'+imageID+'/',
        data:   data,
        success: onSuccess,
        error: onError,
    })
    function onSuccess(data, textStatus, jqXHR){
        console.log(data)
        $('#evaluationcard').attr("trackdetectionID", data.data.image)
        loadWhichTabIsSelected()
        }
    function onError(jqXHR, textStatus, errorThrown){}
}

function loadChromatogram(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/chromatogram/'+trackdetectionID+'/',
        success: onSuccess,
        error: postChromatogram,
      })
      function onSuccess(data, textStatus, jqXHR){
          console.log(data)
          //data.data.image.slice(4,data.data.image.length)
          $('#chromatogramimage').empty()
          $('#chromatogramimage').prepend('<img id="chromatogramID" src="'+data.data.image.slice(4,data.data.image.length)+'" style="width:100%"/>')
        }
}

function postChromatogram(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    showtracks = $('#id_showtracks').is(":checked")
    showsignal = $('#id_showsignal').is(":checked")
    showcrop = $('#id_showcrop').is(":checked")
    showtracknumber = $('#id_showtracknumber').is(":checked")
    trackcolor = $('#id_trackcolor').val()
    signalcolor = $('#id_signalcolor').val()
    data2 = 'show_tracks='+showtracks+'&show_signal='+showsignal+'&show_crop='+showcrop
                +'&show_track_numbers='+showtracknumber+'&track_colour='+trackcolor+'&signal_colour='+signalcolor
        console.log(data2)
        $.ajax({
            method: 'POST',
            url:    window.location.origin+'/chromatogram/'+trackdetectionID+'/',
            data:   data2,
            success: onSuccess,
            error: onError,
        })
        function onSuccess(data, textStatus, jqXHR){
            console.log(data.data.image)
                    $('#chromatogramimage').empty()
                    $('#chromatogramimage').prepend('<img id="chromatogramID" src="'+data.data.image+'" style="width:100%"/>')
            }
        function onError(jqXHR, textStatus, errorThrown){}
}

function loadTrackInspect(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    track = $('#id_tracknumber').val()
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/trackinspect/'+trackdetectionID+'/',//+track+'/',
        success: onSuccess,
        error: postTrackinspect,
      })
      function onSuccess(data, textStatus, jqXHR){
          console.log(data)
          $('#trackinspectimage').empty()
          $('#trackinspectimage').prepend('<img id="trackinspectRgbID" onerror="trackinspectPost()" src="'+data.data.rgb_densitogram+'" style="width:100%"/>')
          $('#trackinspectimage').prepend('<img id="trackinspectID" onerror="trackinspectPost()" src="'+data.data.track_image+'" style="width:100%"/>')
        }
}
function postTrackinspect(){
    track = $('#id_tracknumber').val()
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/trackinspect/'+trackdetectionID+'/'+track+'/',
        success: onSuccess,
        error: onError,
    })
    function onSuccess(data, textStatus, jqXHR){
        console.log(data)
        $('#trackinspectimage').empty()
        $('#trackinspectimage').prepend('<img id="trackinspectRgbID" onerror="trackinspectPost()" src="'+data.data.rgb_densitogram+'" style="width:100%"/>')
        $('#trackinspectimage').prepend('<img id="trackinspectID" onerror="trackinspectPost()" src="'+data.data.track_image+'" style="width:100%"/>')

    }
    function onError(jqXHR, textStatus, errorThrown){}
}

function loadTracksort(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    rf = $('#id_rf').val()
    data = "rf="+rf
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/tracksort/'+trackdetectionID+'/',
        data: data,
        success: onSuccess,
        error: onError,
      })
      function onSuccess(data, textStatus, jqXHR){
          console.log(data)
          $('#tracksortimage').empty()
          $('#tracksortimage').prepend('<img id="tracksortID" src="'+data.data.sorted_image+'" style="width:100%"/>')
        }
      function onError(jqXHR, textStatus, errorThrown){
    }
}

function loadPCA(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/pcaanalysis/'+trackdetectionID+'/',
        success: function(data, textStatus, jqXHR){
                console.log(data)
                $('#pcaimage').empty()
                $('#pcaimage').prepend('<img id="pca2ID" src="'+data.data.explained_variance+'" style="width:100%"/>')
                $('#pcaimage').prepend('<img id="pcaID"  src="'+data.data.pca+'" style="width:100%"/>')
              },
        error: postPCA,
        })
}
function postPCA(){
    data2 = "reference=1"
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/pcaanalysis/'+trackdetectionID+'/',
        data: data2,
        success: function (data, textStatus, jqXHR){
            console.log(data)
            $('#pcaimage').empty()
            $('#pcaimage').prepend('<img id="pca2ID" src="'+data.data.explained_variance+'" style="width:100%"/>')
            $('#pcaimage').prepend('<img id="pcaID"  src="'+data.data.pca+'" style="width:100%"/>')
            },
            })
}

function loadHCA(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/hcaanalysis/'+trackdetectionID+'/',
        success: function(data, textStatus, jqXHR){
                console.log(data)
                $('#hcaimage').empty()
                $('#hcaimage').prepend('<img id="hca2ID" src="'+data.data.hca_tracks+'" style="width:100%"/>')
                $('#hcaimage').prepend('<img id="hcaID"  src="'+data.data.hca+'" style="width:100%"/>')
              },
        error: postHCA,
            })
}
function postHCA(){
    tracks = $('#id_tracks').val()
    data2 = "num_clusters="+tracks+"&reference=1"
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/hcaanalysis/'+trackdetectionID+'/',
        data: data2,
        success: function (data, textStatus, jqXHR){
            console.log(data)
            $('#hcaimage').empty()
            $('#hcaimage').prepend('<img id="hca2ID" src="'+data.data.hca_tracks+'" style="width:100%"/>')
            $('#hcaimage').prepend('<img id="hcaID"  src="'+data.data.hca+'" style="width:100%"/>')
                    },
            })
}

function loadHeatmap(){
    trackdetectionID = $('#evaluationcard').attr("trackdetectionID")
    $.ajax({
        method: 'GET',
        url:    window.location.origin+'/heatmap/'+trackdetectionID+'/',
        success: function(data, textStatus, jqXHR){
                console.log(data)
                $('#heatmapimage').empty()
                $('#heatmapimage').prepend('<img id="heatmapID"  src="'+data.data.heatmap+'" style="width:100%"/>')
              },
        error: postHeatmap(),
            })
}
function postHeatmap(){
    data2 = 'reference=1'
    $.ajax({
        method: 'POST',
        url:    window.location.origin+'/heatmap/'+trackdetectionID+'/',
        data: data2,
        success: function (data, textStatus, jqXHR){
            console.log(data)
            $('#heatmapimage').empty()
            $('#heatmapimage').prepend('<img id="heatmapID"  src="'+data.data.heatmap+'" style="width:100%"/>')
                    },
            })
}



$(document).ready(function() {
    list_of_saved.loadList()
});
