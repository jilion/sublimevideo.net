require 'active_support/core_ext'

class PageConstraint
  def self.matches?(request)
    pattern = [Rails.root, 'app', 'views', _resources, "#{request.path.sub(_resources, '')}.html.{haml,slim}"]
              .join('/').squeeze('/')

    Dir[pattern].any?
  end

  private

  def self._resources
    self.to_s.underscore.gsub(/_constraint$/, '')
  end
end

class PagesConstraint < PageConstraint; end
class PressReleasesConstraint < PageConstraint; end
