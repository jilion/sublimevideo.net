class TailorMadePlayerRequestCreator
  attr_reader :tailor_made_player_request

  def initialize(tailor_made_player_request)
    @tailor_made_player_request = tailor_made_player_request
  end

  def create
    if tailor_made_player_request.save
      Librato.increment 'tailor_made_player_request', source: tailor_made_player_request.country
      TailorMadePlayerRequestZendeskImporterWorker.perform_async(tailor_made_player_request.id)
      true
    else
      false
    end
  end

end
