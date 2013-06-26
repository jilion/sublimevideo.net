require 'page_constraint'

class DemoPageConstraint < PageConstraint
  def self.matches?(request)
    path_parts = request.path.split('/')
    demo_page = path_parts.pop
    pattern = [Rails.root, 'app', 'views', resources, path_parts.join('/').sub(resources, ''), "{,*-}#{demo_page}.html.{haml,slim}"]
              .join('/').squeeze('/')

    Dir[pattern].any?
  end
end
