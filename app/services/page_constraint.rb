class PageConstraint
  def self.matches?(request)
    Dir.glob("app/views/#{resources}/#{request.params["page"]}.html.haml").any?
  end

  private

  def self.resources
    self.to_s.underscore.gsub(/_constraint$/, '')
  end
end
