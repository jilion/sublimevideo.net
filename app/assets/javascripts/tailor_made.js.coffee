jQuery(document).ready ->
  if jQuery('.tailor_made section.modules').exists()
    jQuery('section.modules ul').slidify
      visibleSlides: 1
      speed: 5
      previousButtons: jQuery('section.modules button.arrow.previous')
      nextButtons: jQuery('section.modules button.arrow.next')