#= require detectmobilebrowser
# TODO: Replace with minified http://ricostacruz.com/jquery.transit/ v0.1.4 when it's out
#       It should contain a fix for jQuery 1.8
#= require jquery.transit
#= require jquery.slidify
#= require home
#= require why
#= require player

jQuery.fn.exists = -> @length > 0

jQuery(document).ready ->
  SublimeVideo.yourBrowserIsTheBest()
  SublimeVideo.scrollingLinks()

SublimeVideo.yourBrowserIsTheBest = ->
  if (browsersBox = jQuery('#browsers_box')).exists()
    if jQuery.browser.webkit
      if navigator.userAgent.indexOf('Chrome') isnt -1
        browsersBox.addClass 'chrome'
      else # assume Safari
        browsersBox.addClass 'safari'
    else if jQuery.browser.mozilla
      browsersBox.addClass 'firefox'
    else if jQuery.browser.opera
      browsersBox.addClass 'opera'
    else # default IE

SublimeVideo.scrollingLinks = ->
  jQuery("ul.scroll_links li a").each ->
    el = jQuery(this)
    el.click (event) =>
      jQuery('html, body').animate({
        scrollTop: jQuery(el.attr('href')).offset().top
      }, 300)
