jQuery(document).ready ->
  new SublimeVideo.Slideshow(4, 0.6) if jQuery('#features_slides').exists()
  (new SublimeVideo.Quotes).randomShow() if jQuery('section.showcase').exists()
  if jQuery('section.highlights').exists()
    jQuery('section.highlights ul').slidify
      visibleSlides: 3
      speed: 5
      previousButtons: jQuery('section.highlights button.arrow.previous')
      nextButtons: jQuery('section.highlights button.arrow.next')
  new SublimeVideo.NewsTicker(6) if jQuery('.news_ticker').exists()

class SublimeVideo.Slideshow
  constructor: (pause, speed) ->
    @pauseDuration = pause * 1000
    @speed = speed * 1000
    @slideShowWrapper = jQuery('body.home ul.slides')[0];

    @slideNames = []
    jQuery('body.home .slides li').each (index, element) =>
      element = jQuery(element)
      unless element.hasClass('active')
        this.hideElement(element)
      @slideNames.push(this.getBoxName(element))

    @activeBoxIndex = 0
    this.startTimer()
    this.setupObservers()

  isIE: ->
    jQuery.browser.msie

  hideElement: (element) ->
    if this.isIE()
      element.hide()
    else
      element.show()
      element.css(opacity: 0)

  showElement: (element) ->
    if this.isIE()
      element.show()
    else
      element.css(opacity: 1)

  getBoxName: (element) ->
    element.attr('class').replace(/(box|active|\s)/gi, '')

  startTimer: ->
    @timer = setInterval((=> this.nextSlide((@activeBoxIndex + 1) % @slideNames.length)), @pauseDuration)

  nextSlide: (index) ->
    if @activeBoxIndex isnt index
      currentBox = jQuery(".slides li.#{@slideNames[@activeBoxIndex]}")
      nextBox = jQuery(".slides li.#{@slideNames[index]}")
      if @timer and !this.isIE()
        # animation
        currentBox.transition { opacity: 0 }, @speed, =>
          currentBox.css('z-index': 'auto')
          nextBox.css('z-index': 2)
          this.updateActiveClasses(@slideNames[index])
          nextBox.transition { opacity: 1 }, @speed
      else
        currentBox.css('z-index': 'auto')
        currentBox.removeAttr('style')
        this.hideElement(currentBox)

        this.updateActiveClasses(@slideNames[index])
        nextBox.removeAttr('style')
        nextBox.css('z-index': 2)
        this.showElement(nextBox)

      @activeBoxIndex = index

  updateActiveClasses: (name) ->
    jQuery("body.home .slides li.active").removeClass 'active'
    jQuery("body.home .slides_nav a").removeClass 'active'
    jQuery("body.home .slides li.#{name}").addClass 'active'
    jQuery("body.home .slides_nav a.#{name}").addClass 'active'

  setupObservers: ->
    jQuery('body.home .slides_nav a').each (index, element) =>
      element = jQuery(element)
      element.on 'click', (event) =>
        event.preventDefault()
        if @timer
          clearInterval(@timer)
          @timer = null
        index = jQuery.inArray(this.getBoxName(element), @slideNames)
        this.nextSlide(index)

class SublimeVideo.Quotes
  constructor: ->
    @quotes = jQuery("section.showcase .quote")

  randomShow: ->
    randomQuoteIndex = Math.ceil(Math.random() * @quotes.length) - 1
    jQuery(@quotes[randomQuoteIndex]).show()

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
