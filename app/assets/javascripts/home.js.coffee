jQuery(document).ready ->
  new SublimeVideo.Slideshow(10) if jQuery('#slides').exists()
  (new SublimeVideo.Quotes).randomShow() if jQuery('section.showcase').exists()
  if jQuery('section.highlights').exists()
    jQuery('section.highlights ul').slidify
      visibleSlides: 3
      speed: 5
      previousButtons: jQuery('section.highlights button.arrow.previous')
      nextButtons: jQuery('section.highlights button.arrow.next')
  new SublimeVideo.NewsTicker(6) if jQuery('.news_ticker').exists()

class SublimeVideo.Slideshow
  constructor: (pause) ->
    @pauseDuration = pause * 1000

    this.startTimer()
    this.setupObservers()
    
  startTimer: ->
    @timer = setInterval((=> this.showNext()), @pauseDuration)
      
  showNext: (index) ->
    currentSlide = $('#slides .slide.active').first()
    currentSelector = $('ul.selectors li.active').first()
    currentSlide.removeClass('active')
    currentSelector.removeClass('active')
    if index?
      $($('#slides .slide')[index]).addClass('active')
      $($('ul.selectors li')[index]).addClass('active')
    else
      if currentSlide.next().length == 1
        currentSlide.next().addClass('active')
        currentSelector.next().addClass('active')
      else
        $('#slides .slide').first().addClass('active')
        $('ul.selectors li').first().addClass('active')
  
  setupObservers: ->
    $('ul.selectors li a').each (index, element) =>
      element = $(element)
      element.on 'click', (event) =>
        event.preventDefault()
        if @timer
          clearInterval(@timer)
          @timer = null
        this.showNext(index)

  # hideElement: (element) ->
  #   element.hide()
  # 
  # showElement: (element) ->
  #   element.show()
  # 
  # getBoxName: (element) ->
  #   element.attr('class').replace(/(box|active|\s)/gi, '')
  # 
  # startTimer: ->
  #   @timer = setInterval((=> this.nextSlide((@activeBoxIndex + 1) % @slideNames.length)), @pauseDuration)
  # 
  # nextSlide: (index) ->
  #   if @activeBoxIndex isnt index
  #     currentBox = jQuery(".slides li.#{@slideNames[@activeBoxIndex]}")
  #     nextBox = jQuery(".slides li.#{@slideNames[index]}")
  # 
  #     currentBox.css('z-index': 'auto')
  #     currentBox.removeAttr('style')
  #     this.hideElement(currentBox)
  # 
  #     this.updateActiveClasses(@slideNames[index])
  #     nextBox.removeAttr('style')
  #     nextBox.css('z-index': 2)
  #     this.showElement(nextBox)
  # 
  #     @activeBoxIndex = index
  # 
  # updateActiveClasses: (name) ->
  #   jQuery("body.home .slides li.active").removeClass 'active'
  #   jQuery("body.home .slides_nav a").removeClass 'active'
  #   jQuery("body.home .slides li.#{name}").addClass 'active'
  #   jQuery("body.home .slides_nav a.#{name}").addClass 'active'
  # 
  # setupObservers: ->
  #   jQuery('body.home .slides_nav a').each (index, element) =>
  #     element = jQuery(element)
  #     element.on 'click', (event) =>
  #       event.preventDefault()
  #       if @timer
  #         clearInterval(@timer)
  #         @timer = null
  #       index = jQuery.inArray(this.getBoxName(element), @slideNames)
  #       this.nextSlide(index)

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
