SublimeVideo.tailorMadePlayersReady = ->
  if ($modules = $('.tailor_made section.modules')).exists()
    $modules.find('ul').slidify
      visibleSlides: 1
      speed: 5
      previousButtons: $modules.find('button.arrow.previous')
      nextButtons: $modules.find('button.arrow.next')
