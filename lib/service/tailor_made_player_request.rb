module Service
  TailorMadePlayerRequest = Struct.new(:tailor_made_player_request) do

    def create
      if tailor_made_player_request.save
        Librato.increment 'tailor_made_player_request', source: tailor_made_player_request.country
        self.class.delay.import_to_highrise(tailor_made_player_request.id) # this method is in mysv!
        true
      else
        false
      end
    end

  end
end
