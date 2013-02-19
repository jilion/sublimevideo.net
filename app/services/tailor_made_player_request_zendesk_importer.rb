class TailorMadePlayerRequestZendeskImporter
  attr_reader :tailor_made_player_request

  def initialize(tailor_made_player_request)
    @tailor_made_player_request = tailor_made_player_request
  end

  def import
    create_ticket_in_zendesk
  end

  private

  def create_ticket_in_zendesk
    return true if tailor_made_player_request.zendesk_ticket_id?

    zendesk_ticket = ZendeskWrapper.create_ticket(tailor_made_player_request_to_params)

    if zendesk_ticket
      tailor_made_player_request.update_column(:zendesk_ticket_id, zendesk_ticket.id)

      zendesk_ticket
    else
      false
    end
  end

  def tailor_made_player_request_to_params
    {
      subject: ticket_subject,
      comment: { value: ticket_comment },
      uploads: ticket_uploaded_files,
      tags: %w[sales tailor-made],
      requester: { name: tailor_made_player_request.name, email: tailor_made_player_request.email }
    }
  end

  def ticket_subject
    "Tailor-made player request for #{tailor_made_player_request.company}"
  end

  def ticket_comment
    body = ["Contact: #{tailor_made_player_request.name} (#{tailor_made_player_request.email})"]
    body << "Job & company: #{tailor_made_player_request.job_title} at #{tailor_made_player_request.company}"
    body << "Website: #{tailor_made_player_request.url}"
    body << "Country: #{Country[tailor_made_player_request.country].name}"
    topic = if tailor_made_player_request.topic == 'other'
      tailor_made_player_request.topic_other_detail
    else
      I18n.t("activerecord.attributes.tailor_made_player_request.topic_#{tailor_made_player_request.topic}")
    end
    body << "Topic: #{topic}"
    if tailor_made_player_request.topic_standalone_detail?
      body << "Main agency: #{tailor_made_player_request.topic_standalone_detail}"
    end
    body << "Description: #{tailor_made_player_request.description}"

    body.join("\n\n")
  end

  def ticket_uploaded_files
    if tailor_made_player_request.document.present?
      tmp_file = Tempfile.new(['tailor_made_player_request_document', File.extname(tailor_made_player_request.document.path)], encoding: 'ASCII-8BIT')
      tmp_file.write(tailor_made_player_request.document.read)

      [tmp_file]
    end
  end
end
