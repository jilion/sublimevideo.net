class PressReleasesController < ApplicationController

  def show
    @body_class = 'press_release'

    expires_in 5.minutes, public: true
    if stale?(etag: page_file.path, last_modified: page_file.mtime, public: true)
      render params[:page]
    end
  end

private

  def page_file
    @page_files ||= {}
    @page_files[params[:page]] ||= File.new(Rails.root.join("app/views/press_releases/#{params[:page]}.html.haml"))
  end

end
