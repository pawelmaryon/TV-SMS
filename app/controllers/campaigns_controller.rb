class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show]
  def index
    @campaigns = Campaign.all
    @invalid_votes = VoteCount.last&.invalid_vote
  end

  def show; end

  def import_votes
    # I thought it will be a nice addition to be able to upload the file through the form
    file = params[:file]
    file_path = file.tempfile.path
    if file.content_type != 'text/plain'
      flash[:error] = 'Only text files (.txt) are allowed.'
      redirect_to campaign_path(params[:id])
      return
    end

    VoteImport.new.import_log_data(file_path)
    total_votes = VoteImport.new.count_lines(file_path)
    VoteCount.create!(valid_vote: (Vote.count.to_s), invalid_vote: (total_votes - Vote.count).to_s)

    redirect_to root_path
  end
  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
