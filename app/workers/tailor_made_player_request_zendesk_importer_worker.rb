class TailorMadePlayerRequestZendeskImporterWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'www'

  def perform(tailor_made_player_request_id)
    tailor_made_player_request = TailorMadePlayerRequest.find(tailor_made_player_request_id)
    TailorMadePlayerRequestZendeskImporter.new(tailor_made_player_request).import
  end
end
