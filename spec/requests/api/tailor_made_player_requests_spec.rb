require 'spec_helper'

describe Api::TailorMadePlayerRequestsController do

  context 'unauthenticated' do
    describe "index" do
      it "returns 401" do
        get '/api/tailor_made_player_requests'
        response.status.should eq 401
      end
    end

    describe "show" do
      it "returns 401" do
        get '/api/tailor_made_player_requests/1'
        response.status.should eq 401
      end
    end

    describe "destroy" do
      it "returns 401" do
        delete '/api/tailor_made_player_requests/1'
        response.status.should eq 401
      end
    end
  end

  context 'authenticated' do
    let(:tailor_made_player_request) { create(:tailor_made_player_request) }
    before { set_api_auth_token }

    describe "index" do
      it "returns 200" do
        get '/api/tailor_made_player_requests.json', {}, @env
        response.status.should eq 200
      end

      it "sets pagination headers" do
        get '/api/tailor_made_player_requests.json', {}, @env
        response.headers['X-Page'].should eq '1'
        response.headers['X-Per-Page'].should eq '25'
        response.headers['X-Total-Count'].should eq '0'
      end
    end

    describe "show" do
      before { tailor_made_player_request }

      it "returns 200" do
        get "/api/tailor_made_player_requests/#{tailor_made_player_request.id}.json", {}, @env
        response.status.should eq 200
      end

      it "contains tailor made player request data" do
        get "/api/tailor_made_player_requests/#{tailor_made_player_request.id}.json", {}, @env
        MultiJson.load(response.body)["id"].should eq tailor_made_player_request.id
      end
    end

    describe "destroy" do
      before { tailor_made_player_request }

      it "returns 204" do
        delete "/api/tailor_made_player_requests/#{tailor_made_player_request.id}.json", {}, @env
        response.status.should eq 204
      end

      it "contains tailor made player request data" do
        delete "/api/tailor_made_player_requests/#{tailor_made_player_request.id}.json", {}, @env
        TailorMadePlayerRequest.count.should eq 0
      end
    end
  end
end
