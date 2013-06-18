class Demos

  def self.for(feature)
    Dir[Rails.root.join('app', 'views', 'demos', feature, '*.html.slim')].map do |demo|
      File.basename(demo, '.html.slim')
    end
  end

end
