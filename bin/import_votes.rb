#!/usr/bin/env ruby
require_relative '../app/models/campaign.rb'

def import_log_data(file_path)
  File.open(file_path, 'r') do |file|
    campaigns = {}
    candidates = {}
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
        campaign_name = matches[3]
        validity = matches[4]
        choice = matches[5]
        conn = matches[6]
        msisdn = matches[7]
        guid = matches[8]
        shortcode = matches[9]
        # four lines below are called memoization - TODO: Please educate yourself about it
        campaigns[campaign_name] ||= Campaign.find_or_create_by(name: campaign_name, shortcode: shortcode)
        campaign = campaigns[campaign_name]
        candidates[choice] ||= Candidate.find_or_create_by(name: choice, campaign: campaign)
        candidate = candidates[choice]
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

import_log_data('public/votes.txt')
=begin
to run this script in the terminal, type: time rails runner bin/import_votes.rb
time will give you a time in which the script was executed
=end
