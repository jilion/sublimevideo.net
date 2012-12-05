SublimeVideo.homeReady = ->
  sublime.ready ->
    sublime('lightbox_horizon').on
      open: ->
        slideshow.stopTimer() if slideshow
      close: ->
        slideshow.startTimer() if slideshow

    sublime.players.on 'ready', (player) ->
      if player.videoId() is 'video_horizon'
        player.on 'action:showcases', ->
          document.location.href = '/customer-showcase'
        player.on 'action:teamup', ->
          document.location.href = '/tailor-made-players-requests/new'
        player.on 'action:signup', ->
          sublime('lightbox_horizon').close()
          SublimeVideo.UI.Utils.openAccountPopup('signup')

  if ($slides = $('#slides')).exists()
    slideshow = new SublimeVideo.Slideshow($slides, 10)

  # (new SublimeVideo.Quotes).randomShow() if jQuery('section.showcase').exists()

  if ($highlights = $('section.highlights')).exists()
    $highlights.find('ul').slidify
      visibleSlides: 3
      speed: 5
      previousButtons: $highlights.find('button.arrow.previous')
      nextButtons: $highlights.find('button.arrow.next')

  new SublimeVideo.NewsTicker(6) if $('.news_ticker').exists()

class SublimeVideo.Slideshow
  constructor: (@div, pause) ->
    @pauseDuration = pause * 1000

    this.startTimer()
    this.setupObservers()

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
      element = $(element)
      element.on 'click', (event) =>
        event.preventDefault()
        this.stopTimer()
        this.showNext(index)


# class SublimeVideo.Quotes
#   constructor: ->
#     @quotes = jQuery("section.showcase .quote")
#
#   randomShow: ->
#     randomQuoteIndex = Math.ceil(Math.random() * @quotes.length) - 1
#     jQuery(@quotes[randomQuoteIndex]).show()

class SublimeVideo.NewsTicker
  constructor: (pause) ->
    @pauseDuration = pause * 1000
    @news = jQuery('.news_ticker .news')
    @activeBoxIndex = 0
    this.startTimer()

  startTimer: ->
    @timer = setInterval((=> this.nextNews(@activeBoxIndex + 1)), @pauseDuration)

  nextNews: (index) ->
    currentEl = jQuery(@news[@activeBoxIndex])

    @activeBoxIndex = index % @news.length
    nextEl = jQuery(@news[@activeBoxIndex])

    currentEl.transition({
      opacity: 0
    }, =>
      currentEl.hide()
      nextEl.css({ opacity : 0 }).show().transition({
        opacity: 1
      })
    )
