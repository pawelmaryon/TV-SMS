require 'rails_helper'

RSpec.describe Campaign, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "Associations" do
    it { should have_and_belong_to_many(:candidates) }
    it { should have_many(:votes) }
  end
end
