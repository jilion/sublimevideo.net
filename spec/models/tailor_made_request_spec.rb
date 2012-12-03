require 'spec_helper'

describe TailorMadeRequest do
  context "Factory" do
    subject { create(:tailor_made_request) }

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

    [:name, :email, :topic, :description].each do |attribute|
      it { should validate_presence_of(attribute) }
    end

    TailorMadeRequest::TOPICS.each do |topic|
      it { should allow_value(topic).for(:topic) }
    end
  end # Validations

end
