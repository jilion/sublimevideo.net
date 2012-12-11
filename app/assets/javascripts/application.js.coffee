#= require sublimevideo
#= require detectmobilebrowser
# TODO: Replace with minified http://ricostacruz.com/jquery.transit/ v0.1.4 when it's out
#       It should contain a fix for jQuery 1.8
#= require jquery.transit
#= require jquery.slidify
#= require home
#= require horizon_framework
#= require modular_player
#= require tailor_made_players
#= require_self
#= require google-analytics-turbolinks
#= require turbolinks

$.fn.exists = -> @length > 0

SublimeVideo.wwwDocumentReady = ->
  SublimeVideo.prepareVideoPlayers()
  SublimeVideo.homeReady() if $('body.home').exists()
  SublimeVideo.modularPlayerReady() if $('body.features').exists()
  SublimeVideo.horizonFrameworkReady() if $('body.horizon').exists()
  SublimeVideo.tailorMadePlayersReady() if $('body.tailor_made').exists()
  SublimeVideo.playlistDemo = new SublimeVideo.Playlist('playlist')

$(document).ready ->
  SublimeVideo.wwwDocumentReady()

$(window).bind 'page:change', ->
  SublimeVideo.documentReady()
  SublimeVideo.wwwDocumentReady()
  SublimeVideo.UI.updateActiveItemMenus()
  setTimeout scrollToHash, 500

scrollToHash = ->
  if document.location.hash isnt ''
    if ($elToScrollTo = $(document.location.hash)).exists()
      $(document.body).animate({ scrollTop: $elToScrollTo.offset()['top'] })

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
  player.on 'action:productinfo', ->
    window.open $("##{player.videoId()}").attr('data-product-url')
