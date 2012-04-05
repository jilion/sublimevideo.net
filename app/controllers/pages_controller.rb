class PagesController < ApplicationController
  caches_page :show
  before_filter { @page_caching = true }
  before_filter { redirect_to_my }

  def show
    @body_class = params[:page]

    if stale?(etag: page_md5, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

private

  def redirect_to_my
    if logged_in_cookie?
     if %w[login signup].include?(params[:p])
        redirect_to 'https://my.sublimevideo.net'
      elsif params[:page] == 'help'
        redirect_to 'https://my.sublimevideo.net/help'
      end
    end
  end

  def page_md5
    Digest::SHA1.file(page_file).to_s
  end

  def page_file
    @page_file ||= File.new(Rails.root.join("app/views/pages/#{params[:page]}.html.haml"))
  end

end
