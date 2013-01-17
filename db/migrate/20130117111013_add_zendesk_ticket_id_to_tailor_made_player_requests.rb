class AddZendeskTicketIdToTailorMadePlayerRequests < ActiveRecord::Migration
  def change
    add_column :tailor_made_player_requests, :zendesk_ticket_id, :integer
  end
end
