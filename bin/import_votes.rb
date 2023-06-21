#!/usr/bin/env ruby
require_relative '../app/models/campaign.rb'

def import_log_data(file_path)
  File.open(file_path, 'r') do |file|
    file.each_line do |line|
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
      candidate = Candidate.find_or_create_by(name: choice, campaign: campaign)

      Vote.create!(
        campaign: campaign,
        validity: validity,
        choice: choice,
        conn: conn,
        msisdn: msisdn,
        guid: guid,
        shortcode: shortcode
      )
    end
  end
end

import_log_data('app/public/votes.txt')