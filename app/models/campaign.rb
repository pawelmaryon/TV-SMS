class Campaign < ApplicationRecord
  has_and_belongs_to_many :candidates
  has_many :votes
end
