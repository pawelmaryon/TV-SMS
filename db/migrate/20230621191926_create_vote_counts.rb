class CreateVoteCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :vote_counts do |t|
      t.string :valid_vote
      t.string :invalid_vote

      t.timestamps
    end
  end
end
