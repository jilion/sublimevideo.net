# coding: utf-8
require 'spec_helper'

feature 'Error Pages' do

  describe '404' do
    scenario 'visiting a non-existent page shows a 404 page' do
      visit '/foo'

      page.should have_content '404'
    end
  end

  # describe '500' do
  #   scenario 'visiting a non-existent page shows a 500 page' do
  #     visit '/foo'
  # 
  #     page.should have_content '500'
  #   end
  # end

end
