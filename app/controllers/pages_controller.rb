class PagesController < ApplicationController
  before_filter :handle_help_page, :redirect_to_my

  def show
    @body_class = params[:page]

    expires_in 5.minutes, public: true
    if stale?(etag: page_file.path, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

private

  def handle_help_page
    if params[:page] == 'help'
      if logged_in_cookie?
        redirect_to 'https://my.sublimevideo.net/help'
      else # no cache
        @body_class = 'help'
        render 'help'
      end
    end
  end

  def redirect_to_my
    if logged_in_cookie? && %w[login signup].include?(params[:p])
      redirect_to "https://my.sublimevideo.net/#{params[:p]}"
    end
  end

  def page_file
    @page_files ||= {}
    @page_files[params[:page]] ||= File.new(Rails.root.join("app/views/pages/#{params[:page]}.html.haml"))
  end

end
