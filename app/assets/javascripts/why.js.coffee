SublimeVideo.whyReady = ->
  if jQuery('section.slide').exists()
    jQuery('section.showcases ul').slidify
      visibleSlides: 2
      speed: 5
      previousButtons: jQuery('section.showcases button.arrow.previous')
      nextButtons: jQuery('section.showcases button.arrow.next')
