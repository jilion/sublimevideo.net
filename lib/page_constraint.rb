class PageConstraint
  def self.matches?(request)
    pages = Dir.glob("app/views/#{resources}/*.html.haml").map { |page|
      page.match(%r(app/views/#{resources}/(.*)\.html\.haml))[1]
    }
    pages.include?(request.params["page"])
  end

  private

  def self.resources
    self.to_s.underscore.gsub(/_constraint/, '')
  end
end
