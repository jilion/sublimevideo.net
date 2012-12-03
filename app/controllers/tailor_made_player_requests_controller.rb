class TailorMadePlayerRequestsController < ApplicationController

  def new
    @tailor_made_player_request = TailorMadePlayerRequest.new
  end

  def create
    @tailor_made_player_request = TailorMadePlayerRequest.new(params[:tailor_made_player_request])
    if @tailor_made_player_request.save
      redirect_to '/tailor-made-players'
    end
  end

end
