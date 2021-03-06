# encoding: utf-8
class TailorMadePlayerRequestDocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type

  def fog_public
    false
  end

  def fog_directory
    ENV['S3_TAILOR_MADE_PLAYER_REQUESTS_BUCKET']
  end

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.test?
      "uploads/tailor_made_player_requests"
    else
      super
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(pdf zip)
  # end

end
