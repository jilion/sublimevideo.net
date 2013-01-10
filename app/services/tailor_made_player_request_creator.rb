TailorMadePlayerRequestCreator = Struct.new(:tailor_made_player_request) do

  def create
    if tailor_made_player_request.save
      Librato.increment 'tailor_made_player_request', source: tailor_made_player_request.country
      TailorMadePlayerRequestHighriseImporterWorker.perform_async(tailor_made_player_request.id)
      true
    else
      false
    end
  end

end
