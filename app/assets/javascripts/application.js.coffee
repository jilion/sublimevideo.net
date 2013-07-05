#= require sublimevideo
# TODO: Replace with minified http://ricostacruz.com/jquery.transit/ v0.1.4 when it's out
#       It should contain a fix for jQuery 1.8
#= require jquery.transit.min
#= require jquery.slidify
#= require home
#= require horizon_framework
#= require features
#= require demos
#= require_self
#= require prism-line-highlight
#= require snap.min
#= require google-analytics-turbolinks
#= require turbolinks

# Ensure we don't have new relic errors
window.NREUMQ = window.NREUMQ || []

# iPhone/iPad viewport fix
if navigator.userAgent.match(/iPhone/i) or navigator.userAgent.match(/iPad/i)
  viewportmeta = document.querySelector("meta[name=\"viewport\"]")
  if viewportmeta
    viewportmeta.content = "width=device-width, minimum-scale=1.0, maximum-scale=1.0"
    document.addEventListener("gesturestart", (()->
      viewportmeta.content = "width=device-width, minimum-scale=0.25, maximum-scale=1.6"
    ), false)

SublimeVideo.wwwDocumentReady = ->
  SublimeVideo.prepareVideoPlayers()
  SublimeVideo.homeReady()
  SublimeVideo.featuresReady() if $('section.features').exists()
  SublimeVideo.horizonFrameworkReady() if $('body.horizon').exists()
  SublimeVideo.demosReady() if $('.two-col-wrapper').exists()
  # SublimeVideo.playlistDemo = new SublimeVideo.Playlist('playlist')

$(document).ready ->
  SublimeVideo.wwwDocumentReady()

$(window).bind 'page:change', ->
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
