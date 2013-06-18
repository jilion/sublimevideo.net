class PageConstraint
  def self.matches?(request)
    pattern = [Rails.root, 'app', 'views', resources, "#{request.env['PATH_INFO'].sub(resources, '')}.html.{haml,slim}"]
              .join('/').squeeze('/')

    Dir[pattern].any?
  end

  private

  def self.resources
    self.to_s.underscore.gsub(/_constraint$/, '')
  end
end
