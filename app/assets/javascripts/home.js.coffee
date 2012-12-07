SublimeVideo.homeReady = ->
  SublimeVideo.setupHomeSublime()
  SublimeVideo.setupSolutionsSlideshow()
  SublimeVideo.setupHighlightsSlideshow()
  SublimeVideo.setupNewsTicker()
  # (new SublimeVideo.Quotes).randomShow() if $('section.showcase').exists()

SublimeVideo.setupHomeSublime = ->
  sublime.ready ->
    sublime('lightbox_horizon').on
      open: ->
        SublimeVideo.homeSlideshow.stopTimer() if SublimeVideo.homeSlideshow?
      close: ->
        SublimeVideo.homeSlideshow.startTimer() if SublimeVideo.homeSlideshow?

    sublime.players.on 'ready', (player) ->
      if player.videoId() is 'video_horizon'
        player.on 'action:showcases', ->
          go = -> document.location.href = '/tailor-made-players'
          if player.isFullscreen() then player.exitFullscreen(go) else go()
        player.on 'action:teamup', ->
          go = -> document.location.href = '/tailor-made-players-requests/new'
          if player.isFullscreen() then player.exitFullscreen(go) else go()
        player.on 'action:signup', ->
          go = ->
            sublime('lightbox_horizon').close()
            SublimeVideo.UI.Utils.openAccountPopup('signup')
          if player.isFullscreen() then player.exitFullscreen(go) else go()

SublimeVideo.setupSolutionsSlideshow = ->
  if SublimeVideo.homeSlideshow?
    SublimeVideo.homeSlideshow.kill()
    SublimeVideo.homeSlideshow = null

  if ($slides = $('#slides')).exists()
    SublimeVideo.homeSlideshow = new SublimeVideo.SolutionsSlideshow($slides, 10)

SublimeVideo.setupHighlightsSlideshow = ->
  if ($highlights = $('section.highlights')).exists()
    $highlights.find('ul').slidify
      visibleSlides: 3
      speed: 5
      previousButtons: $highlights.find('button.arrow.previous')
      nextButtons: $highlights.find('button.arrow.next')

SublimeVideo.setupNewsTicker = ->
  if ($newTicker = $('.news_ticker')).exists()
    new SublimeVideo.NewsTicker($newTicker, 6)

class SublimeVideo.SolutionsSlideshow
  constructor: (@div, pause) ->
    @pauseDuration = pause * 1000

    this.startTimer()
    this.setupObservers()

  kill: ->
    this.stopTimer()
    this.clearObservers()

  startTimer: ->
    @timer = setInterval((=> this.showNext()), @pauseDuration)

  stopTimer: ->
    if @timer
      clearInterval(@timer)
      @timer = null

  showNext: (index) ->
    currentSlide = @div.find('.slide.active').first()
    currentSelector = $('ul.selectors li.active').first()
    currentSlide.removeClass('active')
    currentSelector.removeClass('active')
    if index?
      $(@div.find('.slide')[index]).addClass('active')
      $($('ul.selectors li')[index]).addClass('active')
    else
      if currentSlide.next().length == 1
        currentSlide.next().addClass('active')
        currentSelector.next().addClass('active')
      else
        @div.find('.slide').first().addClass('active')
        $('ul.selectors li').first().addClass('active')

  setupObservers: ->
    $('ul.selectors li a').each (index, element) =>
      $(element).on 'click', (event) =>
        event.preventDefault()
        this.stopTimer()
        this.showNext(index)

  clearObservers: ->
    $('ul.selectors li a').each (index, element) =>
      $(element).off 'click'


# class SublimeVideo.Quotes
#   constructor: ->
#     @quotes = $("section.showcase .quote")
#
#   randomShow: ->
#     randomQuoteIndex = Math.ceil(Math.random() * @quotes.length) - 1
#     $(@quotes[randomQuoteIndex]).show()

class SublimeVideo.NewsTicker
  constructor: (@div, pause) ->
    @pauseDuration = pause * 1000
    @news = @div.find('.news')
    @activeBoxIndex = 0
    this.startTimer()

  startTimer: ->
    @timer = setInterval((=> this.nextNews(@activeBoxIndex + 1)), @pauseDuration)

  nextNews: (index) ->
    currentEl = $(@news[@activeBoxIndex])

    @activeBoxIndex = index % @news.length
    nextEl = $(@news[@activeBoxIndex])

    currentEl.transition({
      opacity: 0
    }, =>
      currentEl.hide()
      nextEl.css({ opacity : 0 }).show().transition({
        opacity: 1
      })
    )
