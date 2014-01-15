require 'page_constraint'

class DemoPageConstraint < PageConstraint
  def self.matches?(request)
    path_parts = request.path.sub(%r{\A/#{_resources}/}, '').split('/')
    demo_page  = path_parts.many? ? path_parts.pop : nil

    pattern = [Rails.root, 'app', 'views', _resources, path_parts.join('/')]
    pattern << "{,*-}#{demo_page}.html.slim" if demo_page

    Dir[pattern.join('/').squeeze('/')].any?
  end
end

class DemosConstraint < DemoPageConstraint; end
