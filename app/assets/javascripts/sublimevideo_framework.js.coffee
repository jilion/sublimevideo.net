SublimeVideo.sublimeVideoFrameworkReady = ->
  SublimeVideo.setupSublimeVideoFrameworkSublime()

SublimeVideo.setupSublimeVideoFrameworkSublime = ->
  sublime.ready ->
    if ($videoTrigger = $('#video_framework_trigger')).exists()
      $videoTrigger.on 'click', (event) ->
        event.preventDefault()
        sublime.prepare 'video_framework', (player) ->
          player.on 'action:showcases', ->
            go = -> document.location.href = '/tailor-made-players'
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          player.on 'action:teamup', ->
            go = -> document.location.href = '/tailor-made-players-requests/new'
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          player.on 'action:signup', ->
            go = -> SublimeVideo.UI.Utils.openAccountPopup('signup')
            if player.isFullscreen() then player.exitFullscreen(go) else go()
          # player.play() # not needed anymore, because we have autoplay:true in the <video> now
        $videoTrigger.hide()
