require 'zendesk_api'

module ZendeskWrapper

  def self.create_ticket(params)
    uploads = params.delete(:uploads) || []

    ticket = ZendeskAPI::Ticket.new(client, params)

    save_ticket_with_uploads!(ticket, uploads)
  end

  private

  # @private
  #
  def self.client
    @@_client ||= ZendeskAPI::Client.new do |config|
      config.url      = ENV['ZENDESK_API_URL']
      config.username = "#{ENV['ZENDESK_USERNAME']}/token"
      config.password = ENV['ZENDESK_API_TOKEN']

      # Retry uses middleware to notify the user
      # when hitting the rate limit, sleep automatically,
      # then retry the request.
      config.retry = true

      # Logger prints to STDERR by default, to e.g. print to stdout:
      # require 'logger'
      # config.logger = Logger.new(STDOUT)
    end
  end

  def self.save_ticket_with_uploads!(ticket, uploads)
    uploads.each do |upload|
      ticket.comment.uploads << { file: upload.path, filename: File.basename(upload) }
    end

    rescue_and_retry do
      ticket.save!
    end

    Librato.increment 'support.new_ticket'

    ticket
  end

end
