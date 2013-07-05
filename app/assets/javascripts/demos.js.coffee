SublimeVideo.demosReady = ->
  SublimeVideo.demoSourceSwitch()
  SublimeVideo.hightlightCode()
  SublimeVideo.setupSmallSidebarMenuButton()
  SublimeVideo.setupSidebarScrolling()

SublimeVideo.demoSourceSwitch = ->
  $demoActionButtons = $('a.two-col-action-button')
  $demoActionButtons.on 'click', (e) ->
    e.preventDefault()
    $('#demo').toggle()
    $('#demo_source').toggle()
    $demoActionButtons.toggleClass('active')

SublimeVideo.hightlightCode = ->
  Prism.highlightAll()

SublimeVideo.setupSmallSidebarMenuButton = ->
  snapper = new Snap
    element: $('#two-col-container')[0]
    disable: 'right'
    maxPosition: 240
    minPosition: -240
    touchToDrag: false

  snapper.disable()
  $(window).resize ->
    snapper.close()

  $('a.icon-list').on 'click', (e) ->
    e.preventDefault()
    if snapper.state().state is "left"
      snapper.close()
    else
      snapper.open('left')

SublimeVideo.setupSidebarScrolling = ->
  $sidebar = $('.two-col-sidebar')

  if SublimeVideo.scrollPosition?
    $sidebar.scrollTop(SublimeVideo.scrollPosition)

  $sidebar.on 'scroll', (e) ->
    SublimeVideo.scrollPosition = $sidebar.scrollTop()
