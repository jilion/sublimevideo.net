#= require sublimevideo
# TODO: Replace with minified http://ricostacruz.com/jquery.transit/ v0.1.4 when it's out
#       It should contain a fix for jQuery 1.8
#= require jquery.transit.min
#= require jquery.slidify
#= require home
#= require sublimevideo_framework
#= require modular_player
#= require tailor_made_players
#= require_self
#= require google-analytics-turbolinks
#= require turbolinks

# Ensure we don't have new relic errors
window.NREUMQ = window.NREUMQ || []

SublimeVideo.wwwDocumentReady = ->
  SublimeVideo.prepareVideoPlayers()
  SublimeVideo.homeReady() if $('body.home').exists()
  SublimeVideo.modularPlayerReady() if $('body.features').exists()
  SublimeVideo.sublimeVideoFrameworkReady() if $('body.framework').exists()
  SublimeVideo.tailorMadePlayersReady() if $('body.tailor_made').exists()
  SublimeVideo.playlistDemo = new SublimeVideo.Playlist('playlist')

$(document).ready ->
  SublimeVideo.wwwDocumentReady()

$(window).bind 'page:change', ->
  SublimeVideo.documentReady()
  SublimeVideo.wwwDocumentReady()
  SublimeVideo.UI.updateActiveItemMenus()

SublimeVideo.isMobile = ->
  /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)

SublimeVideo.prepareVideoPlayers = ->
  sublime.ready ->
    $('a.sublime').each (index, el) ->
      sublime.prepare el

    $('video.sublime').each (index, el) ->
      if player = sublime(el)
        SublimeVideo.setupProductInfo(player)
      else
        sublime.prepare el, (player) ->
          SublimeVideo.setupProductInfo(player)

  sublime.load()

SublimeVideo.setupProductInfo = (player) ->
  if $("##{player.videoId()}").attr('data-info-enable') is 'true'
    player.on 'action:productinfo', ->
      window.open $("##{player.videoId()}").attr('data-product-url')
