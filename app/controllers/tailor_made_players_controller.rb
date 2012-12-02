class TailorMadePlayersController < ApplicationController

  def new_request
    @tailor_made_request = TailorMadeRequest.new(params[:tailor_made_request])
    if request.post?
      if @tailor_made_request.save
        redirect_to '/tailor-made-players'
      end
    end
  end

end
