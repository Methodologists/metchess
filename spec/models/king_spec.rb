require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move?" do
    it "should check that the new position exists" do
      g = Game.create
      k = King.last
      expect(k.valid_move?(4, 8)).to eq(false)
    end

    it "should check that the new position is allowed by the King's piece rules" do
      g = Game.create
      k = King.last
      expect(k.valid_move?(4, 5)).to eq(false)
    end
  end
end
