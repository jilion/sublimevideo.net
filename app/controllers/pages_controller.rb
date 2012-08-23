class PagesController < ApplicationController
  caches_page :show
  before_filter { @page_caching = true }
  before_filter { redirect_to_my }

  def show
    @body_class = params[:page]

    render params[:page] if fresh_required?
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

  def fresh_required?
    Rails.env.development? || Rails.env.test? || stale?(etag: page_sha1, last_modified: page_file.mtime, public: true)
  end

  def page_sha1
    Digest::SHA1.file(page_file).to_s
  end

  def page_file
    @page_file ||= File.new(Rails.root.join("app/views/pages/#{params[:page]}.html.haml"))
  end

end
