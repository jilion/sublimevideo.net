SublimeVideo.demosReady = ->
  SublimeVideo.demoSourceSwitch()

SublimeVideo.demoSourceSwitch = ->
  $('ul.demo_source_switch a').on 'click', (event) ->
    event.preventDefault()
    $('#demo').toggle()
    $('#demo_source').toggle()
    $('ul.demo_source_switch a').toggleClass('active')
