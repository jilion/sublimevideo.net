module ZendeskWrapper
  include Configurator

  config_file 'zendesk.yml'
  config_accessor :base_url, :api_url, :username, :api_token

  class << self

    def create_ticket(params)
      uploads = params.delete(:uploads) || []

      ticket = ZendeskAPI::Ticket.new(client, params)

      save_ticket_with_uploads!(ticket, uploads)
    end

    private

    def client
      @client ||= ZendeskAPI::Client.new do |config|
        config.url      = self.api_url
        config.username = "#{self.username}/token"
        config.password = self.api_token

        # Retry uses middleware to notify the user
        # when hitting the rate limit, sleep automatically,
        # then retry the request.
        config.retry = true

        # Logger prints to STDERR by default, to e.g. print to stdout:
        # require 'logger'
        # config.logger = Logger.new(STDOUT)
      end
    end

    def save_ticket_with_uploads!(ticket, uploads)
      uploads.each do |upload|
        ticket.comment.uploads << { file: upload.path, filename: File.basename(upload) }
      end

      ticket.save!
      Librato.increment 'support.new_ticket', source: 'zendesk'

      ticket
    end

  end

end
