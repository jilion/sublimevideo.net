module CachedPageRendererControllerHelper
  def render_cached_page
    expires_in 5.minutes, public: true
    if stale?(etag: page_file.path, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

  private

  def page_file
    @page_file ||= File.new(Rails.root.join("app/views/#{controller_name}/#{params[:page]}.html.haml"))
  end
end
