class CreateCampaignsCandidatesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :campaigns, :candidates
  end
end
