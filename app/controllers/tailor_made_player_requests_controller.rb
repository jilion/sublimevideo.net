class TailorMadePlayerRequestsController < ApplicationController
  respond_to :html

  def new
    @tailor_made_player_request = TailorMadePlayerRequest.new
  end

  def create
    @tailor_made_player_request = TailorMadePlayerRequest.new(params[:tailor_made_player_request])

    respond_with(@tailor_made_player_request) do |format|
      if TailorMadePlayerRequestCreator.new(@tailor_made_player_request).create
        format.html { redirect_to thank_you_tailor_made_player_requests_path }
      else
        format.html
      end
    end
  end

  def thank_you
  end

end
