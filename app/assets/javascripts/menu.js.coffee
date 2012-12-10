class SublimeVideo.UI.wwwMenu
  #
  # @param [jQuery Element] element the menu (ul) element
  #
  constructor: (@element) ->

  setActiveItem: ->
    @element.find('.active').removeClass('active')
    @element.find('li').each (index, el) =>
      li = $(el)
      a = li.find('a').first()
      if a.attr('href') == location.href
        li.addClass 'active'
