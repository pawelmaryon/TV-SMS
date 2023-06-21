class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :campaign
  validates :validity, presence: true
  validates :choice, presence: true
  validates :conn, presence: true
  validates :msisdn, presence: true, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
  validates :guid, presence: true
  validates :shortcode, presence: true
end
