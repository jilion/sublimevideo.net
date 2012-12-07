SublimeVideo.horizonFrameworkReady = ->
  SublimeVideo.setupHorizonFrameworkSublime()

SublimeVideo.setupHorizonFrameworkSublime = ->
  sublimevideo.ready ->
    if ($videoTrigger = $('#video_horizon_trigger')).exists()
      $videoTrigger.on 'click', (event) ->
        event.preventDefault()
        $videoTrigger.hide()
        sublimevideo.prepareAndPlay('video_horizon')
