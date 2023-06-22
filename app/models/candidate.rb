class Candidate < ApplicationRecord
  belongs_to :campaign
  has_many :votes
end
