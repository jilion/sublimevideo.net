class PagesController < ApplicationController
  before_filter { redirect_to_my }

  def show
    @body_class = params[:page]

    expires_in 5.minutes, public: true
    if stale?(etag: page_file.path, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

private

  def redirect_to_my
    if logged_in_cookie?
      if %w[login signup].include?(params[:p])
        redirect_to "https://my.sublimevideo.net/#{params[:p]}"
      elsif params[:page] == 'help'
        redirect_to 'https://my.sublimevideo.net/help'
      end
    end
  end

  def page_file
    @page_files ||= {}
    @page_files[params[:page]] ||= File.new(Rails.root.join("app/views/pages/#{params[:page]}.html.haml"))
  end

end
