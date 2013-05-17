class PrivateApi::TailorMadePlayerRequestsController < SublimeVideoPrivateApiController
  has_scope :per, :by_topic, :by_date, :with_topic, :created_before
  before_filter :find_tailor_made_player_request, only: [:show, :destroy]

  def index
    @tailor_made_player_requests = apply_scopes(TailorMadePlayerRequest.scoped)
    @tailor_made_player_requests = @tailor_made_player_requests.page(params[:page])

    respond_with(@tailor_made_player_requests)
  end

  def show
    respond_with(@tailor_made_player_request)
  end

  def destroy
    @tailor_made_player_request.destroy
    respond_with(@tailor_made_player_request)
  end

  def topics
    respond_with(TailorMadePlayerRequest.topics)
  end

  private

  def find_tailor_made_player_request
    @tailor_made_player_request = TailorMadePlayerRequest.find(params[:id])
  end
end
