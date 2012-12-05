SublimeVideo.horizonFrameworkReady = ->
  sublimevideo.ready ->
    if ($videoTrigger = $('#video_horizon_trigger')).exists()
      $videoTrigger.on 'click', (event) ->
        $videoTrigger.hide()
        sublimevideo.prepareAndPlay('video_horizon')

        false

      # sublimevideo.onEnd (sublime) ->
      #   sublimevideo.unprepare('video_horizon')
      #   $videoTrigger.show()
