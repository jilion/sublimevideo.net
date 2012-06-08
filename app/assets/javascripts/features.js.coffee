jQuery(document).ready ->
  jQuery("section.features_boxes li a").each ->
    el = jQuery(this)
    el.click (event) =>
      jQuery('html, body').animate({
        scrollTop: jQuery(el.attr('href')).offset().top
      }, 300)