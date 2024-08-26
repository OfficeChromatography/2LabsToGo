$('#analysistab-list a').on('click', function (e) {
    e.preventDefault()
    $(this).tab('show')
    loadWhichTabIsSelected()
  })

function loadWhichTabIsSelected(){
  selectedTab = $('.nav-link.active').text()
  if (selectedTab=="Chromatogram"){
    //loadChromatogram()
    postChromatogram()
  } else if (selectedTab=="Trackinspect"){
    //loadTrackInspect()
    postTrackinspect()
  } else if (selectedTab=="Tracksort"){
    loadTracksort()
  } else if (selectedTab=="PCA"){
    //loadPCA()
    postPCA()
  } else if (selectedTab=="HCA"){
    //loadHCA()
    postHCA()
  } else if (selectedTab=="Heatmap"){
    // loadHeatmap()
    postHeatmap()
  }
}
