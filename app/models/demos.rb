class Demos

  def self.filenames_for(feature)
    feature = feature.dasherize
    Rails.cache.fetch ['Demos.filenames_for', feature], expires_in: 1.hour do
      Dir[Rails.root.join('app', 'views', 'demos', feature, '*.html.slim')].map do |demo|
        File.basename(demo, '.html.slim')
      end
    end
  end

  def self.paths_for(feature)
    feature = feature.dasherize
    Rails.cache.fetch ['Demos.paths_for', feature], expires_in: 1.hour do
      filenames_for(feature).map { |f| path_from_filename(f) }
    end
  end

  def self.filename_for_path(feature, path)
    self.filenames_for(feature).find { |f| f =~ /#{path}\Z/ }
  end

  def self.path_from_filename(filename)
    filename.sub(/\A\d+-/, '')
  end

end
