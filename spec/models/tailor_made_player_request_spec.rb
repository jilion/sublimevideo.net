require 'spec_helper'

describe TailorMadePlayerRequest do
  context "Factory" do
    subject { create(:tailor_made_player_request) }

    its(:name)        { should eq 'John Doe' }
    its(:email)       { should eq 'john@doe.com' }
    its(:topic)       { should eq 'agency' }
    its(:description) { should eq 'Want a player.' }
    its(:token)       { should =~ /^[a-z0-9]{8}$/i }

    it { should be_valid }
  end

  describe "Validations" do
    subject { build(:tailor_made_player_request) }

    [:name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :description, :document].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    it { should validate_presence_of(:name).with_message('Please fill in Your name') }
    it { should validate_presence_of(:email).with_message('Please fill in your Email address') }
    it { should validate_presence_of(:job_title).with_message('Please fill in your Job title') }
    it { should validate_presence_of(:company).with_message('Please fill in your Company') }
    it { should validate_presence_of(:url).with_message('Please fill in your Website URL') }
    it { should validate_presence_of(:country).with_message('Please fill in your Country') }
    it { should validate_presence_of(:topic).with_message('Please choose the Topic of your request') }
    it { should validate_presence_of(:description).with_message('Please enter a Description') }

    described_class.topics.each do |topic|
      it { should allow_value(topic).for(:topic) }
    end

    describe 'email format' do
      it 'accepts email with email format' do
        build(:tailor_made_player_request).should be_valid
      end

      it 'do not accept email with non-email format' do
        build(:tailor_made_player_request, email: 'foo').should_not be_valid
      end
    end

    describe 'email format' do
      it 'accepts a blank honeypot' do
        build(:tailor_made_player_request, honeypot: '').should be_valid
      end

      it 'do not accept a non-blank honeypot' do
        build(:tailor_made_player_request, honeypot: 'fooo').should_not be_valid
      end
    end
  end # Validations

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

