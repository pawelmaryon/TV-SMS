require 'rails_helper'

RSpec.describe Vote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "Associations" do
    it { should belong_to(:candidate) }
    it { should belong_to(:campaign) }
  end
end
