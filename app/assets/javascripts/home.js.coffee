
jQuery(document).ready ->
  new SublimeVideo.Slideshow(4, 0.6) if jQuery('#features_slides').exists()

class SublimeVideo.Slideshow
  constructor: (pause, speed) ->
    @pauseDuration = pause * 1000
    @speed = speed
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
    element = jQuery(element) # ensure we have a jQuery Element since there's also Prototype in this page...
    if this.isIE()
      element.hide()
    else
      element.show()
      element.css(opacity: 0)

  showElement: (element) ->
    element = jQuery(element) # ensure we have a jQuery Element since there's also Prototype in this page...
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
      currentBox = $$(".slides li.#{@slideNames[@activeBoxIndex]}")[0]
      nextBox = $$(".slides li.#{@slideNames[index]}")[0]
      if @timer and !this.isIE()
        # animation
        @fadeInAnimation = new S2.FX.Morph currentBox,
          duration: @speed
          style: 'opacity:0'
          after: =>
            if @timer
              currentBox.setStyle(zIndex: 'auto')
              nextBox.setStyle(zIndex: 2)
              this.updateActiveClasses(@slideNames[index])
              @fadeOutAnimation.play()
            else
              currentBox.setOpacity(0)
        @fadeOutAnimation = new S2.FX.Morph nextBox,
          duration: @speed
          style: 'opacity:1'

        @fadeInAnimation.play()
      else
        # no timer or ie
        if @fadeInAnimation
          @fadeInAnimation.cancel()
          @fadeInAnimation = null

        if @fadeOutAnimation
          @fadeOutAnimation.cancel()
          @fadeOutAnimation = null

        currentBox.setStyle(zIndex: 'auto')

        this.updateActiveClasses(@slideNames[index])
        currentBox.removeAttribute('style')
        this.hideElement(currentBox)
        nextBox.removeAttribute('style')
        this.showElement(nextBox)
        nextBox.setStyle(zIndex: 2)

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
        if @timer
          clearInterval(@timer)
          @timer = null
        index = @slideNames.indexOf(this.getBoxName(element))
        this.nextSlide(index)
        event.preventDefault()