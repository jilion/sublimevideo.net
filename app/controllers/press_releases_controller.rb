class PressReleasesController < ApplicationController
  caches_page :show
  before_filter { @page_caching = true }

  def show
    @body_class = 'press_release'

    if stale?(etag: page_md5, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

private

  def page_md5
    Digest::SHA1.file(page_file).to_s
  end

  def page_file
    @page_file ||= File.new(Rails.root.join("app/views/press_releases/#{params[:page]}.html.haml"))
  end


end
