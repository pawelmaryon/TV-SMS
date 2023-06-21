class AddCandidateIdToVotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :votes, :candidate, null: false, foreign_key: true
  end
end
