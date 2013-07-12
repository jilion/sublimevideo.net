require 'spec_helper'

describe PagesController do

  %w[home framework tailor-made-players help].each do |page|
    it "responds with success to /#{page}" do
      get :show, page: page
      response.should render_template("pages/#{page}")
    end
  end

  context "with no user logged-in" do
    %w[login signup].each do |param|
      it "responds with success to /?p=#{param}" do
        get :show, page: 'home', p: param
        response.should redirect_to("http://my.test.host/#{param}")
      end
    end
  end

  context "with user logged-in" do
    before { cookies[:l] = '1' }

    %w[login signup].each do |param|
      it "/?p=#{param} redirects" do
        get :show, page: 'home', p: param
        response.should redirect_to("http://my.test.host/#{param}")
      end
    end

    it "/help redirects" do
      get :show, page: 'help'
      response.should redirect_to("http://my.test.host/help")
    end
  end

end
