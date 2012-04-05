#= require prototype
#= require s2
#= require home
#= require player

jQuery(document).ready ->
  SublimeVideo.yourBrowserIsTheBest()

SublimeVideo.yourBrowserIsTheBest = ->
  if (browsersBox = jQuery('#browsers_box')).length > 0
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
