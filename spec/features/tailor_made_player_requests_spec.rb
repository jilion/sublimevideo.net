# coding: utf-8
require 'spec_helper'

# FIXME: Remove this?
feature "TailorMadePlayerRequest", :vcr do

  pending "creation" do
    scenario 'tailor-made player request is created in DB and creates a Zendesk ticket' do
      visit '/'
      within 'header' do
        click_link 'Tailor-Made Players'
      end
      first(:link, 'Need a tailor-made player? Contact us').click

      fill_in 'Your name', with: 'John Doe'
      fill_in 'Email address', with: 'remy@jilion.com'
      fill_in 'Job title', with: 'Mr. Dev'
      fill_in 'Company', with: 'John Doe SA'
      fill_in 'Website URL', with: 'rymai.me'
      select 'Switzerland', from: 'Country'
      choose 'I am an agency and I would like to design and sell tailor-made players to my customers.'
      fill_in 'How can we help you?', with: 'I want a gorgeous tailor-made player!'

      click_on 'Submit'

      page.should have_content 'Thank you!'
      page.should have_content 'We have received your contact request. We will get back to you as soon as possible.'

      Sidekiq::Worker.drain_all
      TailorMadePlayerRequest.first.zendesk_ticket_id.should be_present
    end
  end

end
