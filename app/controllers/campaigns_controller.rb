class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]
  def index
    @campaigns = Campaign.all
    total_votes = count_lines('public/votes.txt')
    @invalid_votes = total_votes - Vote.count
  end

  def show
  end

  def import_votes
    import_log_data('public/votes.txt')
  end
  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
  
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
          line_regex = /VOTE (\d+) Campaign:([^ ]+) Validity:([^ ]+) Choice:([^ ]+) CONN:([^ ]+) MSISDN:([^ ]+) GUID:([^ ]+) Shortcode:(\d+)/
          matches = line.match(line_regex)
  
          next unless matches
  
          campaign_name = matches[2]
          validity = matches[3]
          choice = matches[4]
          conn = matches[5]
          msisdn = matches[6]
          guid = matches[7]
          shortcode = matches[8]
  
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
