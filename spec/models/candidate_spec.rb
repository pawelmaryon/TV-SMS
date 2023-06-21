require 'rails_helper'

RSpec.describe Candidate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "Associations" do
    it { should have_many(:votes) }
    it { should belong_to(:campaign) }
  end
end
