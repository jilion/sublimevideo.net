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
    [:name, :email, :job_title, :company, :url, :country, :topic, :topic_standalone_detail, :topic_other_detail, :description, :document].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    # [:name, :email, :job_title, :company, :url, :country, :topic, :description].each do |attribute|
    #   it { should validate_presence_of(attribute) }
    # end

    described_class::TOPICS.each do |topic|
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
#
# Indexes
#
#  index_tailor_made_player_requests_on_created_at  (created_at)
#  index_tailor_made_player_requests_on_topic       (topic)
#

