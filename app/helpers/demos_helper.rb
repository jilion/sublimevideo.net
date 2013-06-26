module DemosHelper

  def current_feature
    @current_feature ||= request.path.split('/')[2]
  end

  def demo_title(demo)
    t("demos.#{demo.dasherize}", default: demo.sub(/\A(\d+-)?/, '').underscore.humanize)
  end

  def demo_active_class(feature, demo)
    'demo-sidebar-active' if request.path == "/demos/#{feature}/#{demo}"
  end

  def render_demo_html
    content_tag(:div, _render_demo_file('html'), id: 'demo')
  end

  def inject_demo_css
    content_tag(:style, _render_demo_file('css'))
  end

  def inject_demo_js
    content_tag(:script, _render_demo_file('js'), type: 'text/javascript')
  end

  def render_demo_sources(*languages)
    content_tag(:div, id: 'demo_source', class: 'demo-content-source', style: 'display:none') do
      languages.inject('') do |memo, language|
        memo += content_tag(:h4, _title_for_language(language), class: 'code-label')
        memo += content_tag(:pre, content_tag(:code, render_demo_source(language), class: _class_for_language(language)), class: _class_for_language(language))
        memo
      end.html_safe
    end
  end

  def render_demo_source(file)
    _render_source "#{request.path}/#{file}"
  end

  private

  def _render_demo_file(file)
    render("#{request.path}/#{file}")
  end

  def _render_source(*args)
    @html_encoder ||= HTMLEntities.new
    raw(@html_encoder.encode(render(*args)))
  end

  def _title_for_language(language)
    case language
    when 'html'
      'HTML'
    when 'js'
      'JavaScript'
    when 'css'
      'CSS'
    end
  end

  def _class_for_language(language)
    case language
    when 'html'
      'language-markup'
    when 'js'
      'language-javascript'
    else
      "language-#{language}"
    end
  end

end
