SublimeVideo.horizonFrameworkReady = ->
  SublimeVideo.setupHorizonFrameworkSublime()
  SublimeVideo.pickRandomVideoPoster()

SublimeVideo.setupHorizonFrameworkSublime = ->
  sublimevideo.ready ->
    if ($videoTrigger = $('#video_horizon_trigger')).exists()
      $videoTrigger.on 'click', (event) ->
        event.preventDefault()
        $videoTrigger.hide()
        sublimevideo.prepareAndPlay('video_horizon')

SublimeVideo.pickRandomVideoPoster = ->
  if ($videoTrigger = $('#video_horizon_trigger')).exists()
    img = $videoTrigger.find('img.video_poster')
    video = $("#video_horizon")
    img.hide()
    img.bind 'load', ->
      img.fadeIn()

    imgIndex = Math.floor(Math.random()*6)

    # Fake poster
    img.attr("src", SublimeVideo.horizonVideoPostersPaths[imgIndex])

    # Real poster
    video.attr("poster", SublimeVideo.horizonVideoPostersPaths[imgIndex])
