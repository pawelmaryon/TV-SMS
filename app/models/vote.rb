class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :campaign
  validates :validity, presence: true
end
