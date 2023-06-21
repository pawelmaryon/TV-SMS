class Candidate < ApplicationRecord
  belongs_to :campaign
  has_many :votes
  validates :name, uniqueness: true
end
