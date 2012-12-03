# encoding: utf-8
require_dependency 's3'

class TailorMadeRequestDocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type

  def fog_public
    false
  end

  def fog_directory
    S3.buckets['tailor_made_requests']
  end

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.test?
      "uploads/tailor_made_requests"
    else
      super
    end
  end

  def filename
    "#{model.token}.#{file.extension}" if original_filename.present?
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(pdf zip)
  # end

end
