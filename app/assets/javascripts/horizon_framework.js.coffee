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

    posterId = Math.floor(Math.random()*6) + 1

    # Fake poster
    src = img.attr("src").replace(/poster_[\d]/,"poster_" + posterId)
    img.attr("src", src)

    # Real poster
    posterSrc = video.attr("poster").replace(/poster_[\d]/,"poster_" + posterId)
    video.attr("poster", posterSrc)
