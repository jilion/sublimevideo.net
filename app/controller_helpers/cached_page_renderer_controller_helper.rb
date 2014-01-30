module CachedPageRendererControllerHelper
  def render_cached_page
    expires_in 5.minutes, public: true
    if stale?(etag: page_file.path, last_modified: page_file.mtime, public: true)
      render "#{controller_name}/#{params[:page]}"
    end
  end

  private

  def page_file
    @page_file ||= if path = Dir[File.join('app', 'views', controller_name, "#{params[:page]}.html.{haml,slim}")].try(:first)
      File.new(path)
    end

    @page_file or raise ActionController::RoutingError.new("#{controller_name}/#{params[:page]} couldn't be found.")
  end
end
