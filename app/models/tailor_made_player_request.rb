class TailorMadePlayerRequest < ActiveRecord::Base
  TOPICS = %w[agency standalone platform other]

  attr_accessor :honeypot
  attr_accessible :name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :description, :document, :honeypot

  uniquify :token
  mount_uploader :document, TailorMadePlayerRequestDocumentUploader

  validates :name, :email, :job_title, :company, :url, :country, :topic, :description, presence: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :topic, inclusion: TOPICS, allow_blank: true
  validates :document, file_size: { maximum: 10.megabytes.to_i }
  validate :honeypot_validation

  scope :by_topic, lambda { |way = 'desc'| order{ topic.send(way) } }
  scope :by_date,  lambda { |way = 'desc'| order{ created_at.send(way) } }
  scope :with_topic, lambda { |topic| where(topic: topic) }
  scope :created_before, lambda { |date| where{ created_at <= date } }

  def self.topics
    TOPICS
  end

  private

  def honeypot_validation
    errors.add(:base, "Honeypot must be left blank!") unless honeypot.blank?
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
#  zendesk_ticket_id       :integer
#
# Indexes
#
#  index_tailor_made_player_requests_on_created_at  (created_at)
#  index_tailor_made_player_requests_on_topic       (topic)
#

