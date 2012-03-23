require 'spec_helper'

describe PagesController do

  %w[home demo features plans help].each do |page|
    it "responds with success to /#{page}" do
      get :show, page: page
      response.should render_template("pages/#{page}")
    end
  end

  context "with no user logged-in" do
    %w[login signup].each do |param|
      it "responds with success to /?p=#{param}" do
        get :show, page: 'home', p: param
        response.should render_template("pages/home")
      end
    end
  end

  context "with user logged-in" do
    before { cookies[:l] = '1' }

    %w[login signup].each do |param|
      it "/?p=#{param} redirects" do
        get :show, page: 'home', p: param
        response.should redirect_to("https//my.sublimevideo.net")
      end
    end

    it "/help redirects" do
      get :show, page: 'help'
      response.should redirect_to("https//my.sublimevideo.net/help")
    end
  end

end
