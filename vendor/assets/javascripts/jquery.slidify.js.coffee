# © 2012 Andrea Coiro
(($) ->
  class Range
    constructor: (@start, @count, @modulo) ->
    includes: (value) ->
      end = @start + @count
      if end <= @modulo
        value >= @start and value < end
      else
        (value >= @start and value < @modulo) or (value >= 0 and value < end % @modulo)

  modulo = (value, mod) ->
    value += mod while value < 0
    value % mod
    
  SlideshowDirection =
    Left: 0
    Right: 1
    
  class Slideshow
    constructor: (@element, @options) ->      
      @jElement = $(@element)
      @sliderTimer = null
      @width = @jElement.parent().width()
      
      @slideSize = @width / @options.visibleSlides
      @jElement.css 
        width: @width + 2 * @slideSize
        x: - @slideSize
      self = @
      @slides = []
      @jElement.children().each (index) -> 
        self.slides.push $(@)
      @visibleSlidesRange = new Range (@slides.length - 1), (@options.visibleSlides + 2), @slides.length
      @layoutSlides()
      @bindButtonsToDirection @options.previousButtons, SlideshowDirection.Right
      @bindButtonsToDirection @options.nextButtons, SlideshowDirection.Left
      
      if @isVisible()        
        @start()
      else
        jQuery(window).scroll (event) =>
          if @isVisible()
            jQuery(window).off('scroll')
            @start()
            
    isVisible: ->
      win = jQuery(window)
      yOffset = @jElement.offset().top
      yOffset >= win.scrollTop() and yOffset + 0.66 * @jElement.height() < win.scrollTop() + win.height()
        
    bindButtonsToDirection: (buttons, direction) ->
      if buttons
        buttons.click (e) =>
          e.preventDefault()
          @stopSlider()
          @slideToDirection direction
      
    layoutSlides: ->
      @jElement.css
        x: - @slideSize
      for slide, index in @slides
        if @visibleSlidesRange.includes index
          pos = @xForSlideAtIndex(index)
          op = if pos < @slideSize or pos >= @jElement.width() - @slideSize then 0 else 1          
          slide.css
            position: 'absolute'
            x: pos + 'px'
            y: '0px'
            opacity: if pos < @slideSize or pos >= @jElement.width() - @slideSize then 0 else 1
          slide.show()
        else
          slide.hide()
    
    xForSlideAtIndex: (index) ->
      position = modulo (index - @visibleSlidesRange.start), @visibleSlidesRange.modulo
      @slideSize * position
    
    start: -> @scheduleSliding()
    
    timerDidFire: ->
      @slideToNext()
      @scheduleSliding()
    
    stopSlider: -> clearTimeout @sliderTimer
    
    scheduleSliding: -> @sliderTimer = setTimeout (=> @timerDidFire()), @options.speed * 1000
    
    disableButtons: ->
      @options.nextButtons.attr "disabled", "disabled"
      @options.previousButtons.attr "disabled", "disabled"
    
    enableButtons: ->
      @options.nextButtons.removeAttr "disabled"
      @options.previousButtons.removeAttr "disabled"
    
    slideToNext: -> @slideToDirection SlideshowDirection.Left
            
    slideToPrevious: -> @slideToDirection SlideshowDirection.Right
      
    slideToDirection: (direction) ->
      @disableButtons()
      x = - @slideSize
      x += if direction is SlideshowDirection.Left then - @slideSize else @slideSize
      @jElement.transition x: x
      , =>
        if direction is SlideshowDirection.Left
          start = modulo (@visibleSlidesRange.start + 1), @visibleSlidesRange.modulo
        else
          start = modulo (@visibleSlidesRange.start - 1), @visibleSlidesRange.modulo
        @visibleSlidesRange.start = start
        @layoutSlides()              
        @enableButtons()
      for slide, index in @slides
        if @visibleSlidesRange.includes index
          pos = @xForSlideAtIndex(index)
          pos += if direction is SlideshowDirection.Left then - @slideSize else @slideSize
          options = {}
          options.opacity = if pos < @slideSize or pos >= @jElement.width() - @slideSize then 0 else 1
          slide.transition options

  $.fn.slidify = (options={}) ->
    defaults = 
      visibleSlides: 1
      speed: 2
    options = $.extend defaults, options
    @each -> slideshow = new Slideshow @, options
) jQuery
