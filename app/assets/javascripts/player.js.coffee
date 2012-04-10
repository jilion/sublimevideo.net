jQuery(document).ready ->
  SublimeVideo.playlistDemo = new SublimeVideo.Playlist('playlist')

ua = navigator.userAgent
SublimeVideo.detectedMobile = ua.indexOf("Mobile") !=-1 ||
                              ua.indexOf('Windows Phone') != -1 ||
                              ua.indexOf('Android') != -1 ||
                              ua.indexOf('webOS') != -1

if typeof(sublimevideo) isnt "undefined"
  sublimevideo.ready ->
    sublimevideo.onStart (sv) ->
      if sv.element.id is "single_video" and !SublimeVideo.detectedMobile
        SublimeVideo.updateModeBox(sv.mode)
      else if sv.element.id is "home_video"
        SublimeVideo.showCredits(true)

    sublimevideo.onEnd (sv) ->
      if matches = sv.element.id.match(/^video(\d+)$/)
        if parseInt(matches[1], 10) < SublimeVideo.playlistDemo.lastVideoIndex
          SublimeVideo.playlistDemo.handleAutoNext(sv.element.id)
        else
          sublimevideo.stop()
      else
        sublimevideo.stop()
        if sv.element.id is "home_video"
          SublimeVideo.showCredits(false)

SublimeVideo.updateModeBox = (mode) ->
  modeSwitcher = jQuery('#mode_switcher')
  newModeText = if mode is 'html5' then 'Flash' else 'HTML5'
  modeSwitcher.attr 'class', "active #{mode}"
  modeSwitcher.find('small em').html(newModeText)

SublimeVideo.showCredits = (onOff) ->
  if (credits = jQuery('#video_credits')).exists()
    if onOff
      timerIn = setTimeout((-> credits.show(1000)), 3000)
    else
      clearTimeout(timerIn)
      credits.hide(1000)

class SublimeVideo.Playlist
  constructor: (playlistWrapperId) ->
    return unless jQuery("##{playlistWrapperId}").exists()

    @playlistWrapperId = playlistWrapperId
    @videosCount = jQuery("##{@playlistWrapperId} .video_wrap").size()

    matches = jQuery("##{@playlistWrapperId} video").attr("id").match(/^video(\d+)$/)
    @firstVideoIndex = parseInt(matches[1], 10)
    @lastVideoIndex = @firstVideoIndex + @videosCount - 1

    this.setupObservers()

    this.loadDemo()

  setupObservers: ->
    jQuery("##{@playlistWrapperId} li").each (index, element) =>
      element = jQuery(element)
      element.click (event) =>
        event.preventDefault()

        unless element.hasClass 'active'
          this.clickOnThumbnail(element.attr('id'))

  loadDemo: ->
    # Only if not the first time here
    this.reset() if @activeVideoId

    @activeVideoId = "video#{@firstVideoIndex}"

    # Show first video
    this.showActiveVideo()

  reset: ->
    # Hide the current active video
    jQuery("##{@playlistWrapperId} .video_wrap.active").removeClass 'active'

    # Get current active video and unprepare it
    # we could have called sublimevideo.unprepare() without any arguments, but this is faster
    sublimevideo.unprepare(@activeVideoId)

    # Deselect its thumbnail
    jQuery("#thumbnail_#{@activeVideoId}").removeClass('active')

  clickOnThumbnail: (thumbnailId) ->
    # Basically undo all the stuff and bring it back to the point before js kicked in
    this.reset()

    # Set the new active video
    @activeVideoId = thumbnailId.replace(/^thumbnail_/, "")

    # And show the video
    this.showActiveVideo()

    # And finally, prepare and play it
    sublimevideo.prepareAndPlay(@activeVideoId)

  showActiveVideo: ->
    # Select its thumbnail
    jQuery("#thumbnail_#{@activeVideoId}").addClass('active')

    # Show the video
    jQuery("##{@activeVideoId}").parent('.video_wrap').addClass('active')

  handleAutoNext: (endedVideoId) ->
    nextId = parseInt(endedVideoId.replace(/^video/, ""), 10) + 1
    if nextId > 1 and nextId <= @lastVideoIndex
      this.clickOnThumbnail("thumbnail_video#{nextId}")
