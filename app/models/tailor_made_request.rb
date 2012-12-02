class TailorMadeRequest < ActiveRecord::Base

  attr_accessible :name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :comment, :document

  mount_uploader :document, TailorMadeRequestDocumentUploader

  uniquify :token

  TOPICS = %w[agency standalone platform other] unless defined? TOPICS

  validates :name, :email, :topic, :comment, presence: true
  validates :topic, inclusion: TOPICS

end
