class PageConstraint
  def self.matches?(request)
    param = request.params["page"]
    return unless param =~ /^[a-z-]+$/
    Dir.glob("app/views/#{_resources}/#{param}.html.haml").any?
  rescue
    false
  end

  private

  def self._resources
    self.to_s.underscore.gsub(/_constraint$/, '')
  end
end
