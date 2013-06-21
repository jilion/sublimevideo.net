SublimeVideo.demosReady = ->
  SublimeVideo.demoSourceSwitch()
  SublimeVideo.hightlightCode()
  SublimeVideo.sidebarMenu()

SublimeVideo.demoSourceSwitch = ->
  $demoActionButtons = $('a.demo-action-button')
  $demoActionButtons.on 'click', (e) ->
    e.preventDefault()
    $('#demo').toggle()
    $('#demo_source').toggle()
    $demoActionButtons.toggleClass('active')

SublimeVideo.hightlightCode = ->
  Prism.highlightAll()

SublimeVideo.sidebarMenu = ->
  # $('#show-menu').sidr()
  snapper = new Snap
    element: $("#demo-container")[0]
    disable: 'right'
    maxPosition: 220
    minPosition: -220
    touchToDrag: false

  snapper.disable()
  # if Modernizr.mq("screen and (min-width:900px)")
  #   snapper.disable()
  #
  # $(window).resize ->
  #   if Modernizr.mq("screen and (max-width:900px)")
  #     snapper.enable()
  #   else
  #     snapper.disable()

  $('a.icon-list').on 'click', (e) ->
    e.preventDefault()
    if snapper.state().state == "left"
      snapper.close()
    else
      snapper.open('left')
