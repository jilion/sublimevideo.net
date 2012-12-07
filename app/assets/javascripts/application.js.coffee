#= require sublimevideo
#= require detectmobilebrowser
# TODO: Replace with minified http://ricostacruz.com/jquery.transit/ v0.1.4 when it's out
#       It should contain a fix for jQuery 1.8
#= require jquery.transit
#= require jquery.slidify
#= require home
#= require modular_player
#= require horizon_framework
#= require tailor_made_players
#= require_self
#= require google-analytics-turbolinks
#= require turbolinks

$.fn.exists = -> @length > 0

SublimeVideo.wwwDocumentReady = ->
  SublimeVideo.homeReady() if $('.home').exists()
  SublimeVideo.modularPlayerReady() if $('.features').exists()
  SublimeVideo.horizonFrameworkReady() if $('.horizon').exists()
  SublimeVideo.tailorMadePlayersReady() if $('.tailor_made').exists()
  SublimeVideo.playlistDemo = new SublimeVideo.Playlist('playlist')

$(document).ready ->
  SublimeVideo.wwwDocumentReady()

$(window).bind 'page:change', ->
  sublime.ready ->
    $('.sublime').each (index, el) ->
      sublime.prepare el
  sublime.load()

  SublimeVideo.documentReady()
  SublimeVideo.wwwDocumentReady()

  setTimeout scrollToHash, 200

scrollToHash = ->
  if document.location.hash isnt ''
    if ($elToScrollTo = $(document.location.hash)).exists()
      $(document.body).animate({ scrollTop: $elToScrollTo.offset()['top'] })
