require 'file_size_validator'

class TailorMadePlayerRequest < ActiveRecord::Base

  attr_accessible :name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :description, :document

  mount_uploader :document, TailorMadePlayerRequestDocumentUploader

  TOPICS = %w[agency standalone platform other] unless defined? TOPICS

  validates :name, :email, :job_title, :company, :url, :country, :topic, :description, presence: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
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

# == Schema Information
#
# Table name: tailor_made_player_requests
#
#  company                 :string(255)
#  country                 :string(255)
#  created_at              :datetime         not null
#  description             :text             not null
#  document                :string(255)
#  email                   :string(255)      not null
#  highrise_kase_id        :integer
#  id                      :integer          not null, primary key
#  job_title               :string(255)
#  name                    :string(255)      not null
#  token                   :string(255)
#  topic                   :string(255)      not null
#  topic_other_detail      :string(255)
#  topic_standalone_detail :string(255)
#  updated_at              :datetime         not null
#  url                     :string(255)
#
# Indexes
#
#  index_tailor_made_player_requests_on_created_at  (created_at)
#  index_tailor_made_player_requests_on_topic       (topic)
#

