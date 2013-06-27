class TailorMadePlayerRequestsController < ApplicationController
  respond_to :html

  def new
    @tailor_made_player_request = TailorMadePlayerRequest.new
  end

  def create
    @tailor_made_player_request = TailorMadePlayerRequest.new(tailor_made_player_request_params)

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

  private

  def tailor_made_player_request_params
    params.require(:tailor_made_player_request).permit(:name, :email, :job_title,
                                                       :company, :url, :country, :topic,
                                                       :topic_standalone_detail, :topic_other_detail,
                                                       :description, :document, :honeypot)
  end

end
