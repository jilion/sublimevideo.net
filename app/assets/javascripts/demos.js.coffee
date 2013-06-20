SublimeVideo.demosReady = ->
  SublimeVideo.demoSourceSwitch()
  SublimeVideo.hightlightCode()

SublimeVideo.demoSourceSwitch = ->
  $demoActionButtons = $('a.demo-action-button')
  $demoActionButtons.on 'click', (e) ->
    e.preventDefault()
    $('#demo').toggle()
    $('#demo_source').toggle()
    $demoActionButtons.toggleClass('active')

SublimeVideo.hightlightCode = ->
  Prism.highlightAll()
