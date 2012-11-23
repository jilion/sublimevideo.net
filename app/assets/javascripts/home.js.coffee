jQuery(document).ready ->
  new SublimeVideo.Slideshow(10) if jQuery('#slides').exists()
  # (new SublimeVideo.Quotes).randomShow() if jQuery('section.showcase').exists()
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
