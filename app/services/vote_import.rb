class VoteImport
  def import_log_data(file_path)
    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        begin
          line.force_encoding('UTF-8').encode!('UTF-8', 'UTF-8', invalid: :replace)
        rescue Encoding::InvalidByteSequenceError => e
          puts "Skipping line due to invalid byte sequence: #{e.message}"
          next
        end

        begin
          line_regex = /(VOTE|DEFAULT) (\d+) Campaign:([^ ]+)(?: Validity:([^ ]+))?(?: Choice:([^ ]+))? CONN:([^ ]+) MSISDN:([^ ]+) GUID:([^ ]+) Shortcode:(\d+)/
          matches = line.match(line_regex)
          next unless matches
          byebug
          campaign_name = matches[3]
          validity = matches[4]
          choice = matches[5]
          conn = matches[6]
          msisdn = matches[7]
          guid = matches[8]
          shortcode = matches[9]

          campaign = Campaign.find_or_create_by(name: campaign_name)

          candidate = Candidate.find_or_initialize_by(name: choice, campaign: campaign)
          candidate.save!
          Vote.create!(
            campaign_id: campaign.id,
            validity: validity,
            choice: choice,
            conn: conn,
            msisdn: msisdn,
            guid: guid,
            shortcode: shortcode,
            candidate_id: candidate.id
          )
        rescue ActiveRecord::RecordInvalid => e
          puts "Failed to create candidate: #{e.message}"
        end
      end
    end
  end

  def count_lines(file_path)
    line_count = 0
    File.foreach(file_path) { line_count += 1 }
    line_count
  end
end