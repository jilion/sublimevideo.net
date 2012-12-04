require 'file_size_validator'

class TailorMadePlayerRequest < ActiveRecord::Base

  attr_accessible :name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :description, :document, :document_cache

  mount_uploader :document, TailorMadePlayerRequestDocumentUploader

  TOPICS = %w[agency standalone platform other] unless defined? TOPICS

  validates :name, :email, :topic, :description, presence: true
  validates :topic, inclusion: TOPICS, allow_blank: true
  validates :document, file_size: { maximum: 10.megabytes.to_i }

  def initialize(*args)
    super
    ensure_unique_token
  end

  def ensure_unique_token
    options = { :length => 8, :chars => ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a }
    begin
      self.token = Array.new(options[:length]) { options[:chars].to_a[rand(options[:chars].to_a.size)] }.join
    end while self.class.exists?(token: token)
  end

end
