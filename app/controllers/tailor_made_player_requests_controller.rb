class TailorMadePlayerRequestsController < ApplicationController
  respond_to :html

  def new
    @tailor_made_player_request = TailorMadePlayerRequest.new
  end

  def create
    @tailor_made_player_request = TailorMadePlayerRequest.new(params[:tailor_made_player_request])

    respond_with(@tailor_made_player_request) do |format|
      if @tailor_made_player_request.save
        format.html { redirect_to '/tailor-made-players', notice: I18n.t('flash.support_requests.create.notice') }
      else
        format.html
      end
    end
  end

end
