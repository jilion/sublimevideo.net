SublimeVideo.featuresReady = ->
  SublimeVideo.moreLinks()
  # SublimeVideo.setupDesignsDemo()

SublimeVideo.moreLinks = ->
  $('a.feature-more').on "click", (event) ->
    event.preventDefault()
    a = $(this)
    a.parents().eq(2).find('.feature-more-wrap').toggle()

    # a.toggle(function() {
    #   a.html('Close <small class="icon-uniF48A"></small>')
    # }, function() {
    #   a.html('More <small class="icon-uniF48B"></small>')
    # });

    # a.toggle((->
    #   a.html('Close <small class="icon-uniF48A"></small>')
    # ), (->
    #   a.html('More <small class="icon-uniF48B"></small>')
    # ))


# SublimeVideo.setupDesignsDemo = ->
#   new SublimeVideo.DesignsDemo($('.design_demo'))
#
# class SublimeVideo.DesignsDemo
#   constructor: (@links) ->
#     @links.on 'click', (event) ->
#       $link = $(event.target)
#       $("#{$link.attr('href')}").attr('data-settings', "player-kit:#{$link.data('kit-id')}")
#       sublime.prepare $link[0], (lightbox) -> lightbox.open()
#
#       false
