require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move?" do
    it "should check that the new position exists" do
      Game.create
      p = [4, -1]
      expect(King.valid_move?(p)).to eq(false)
    end

    it "should check that the new position is allowed by the King's piece rules" do
      Game.create
      p = [4, 4]
      expect(King.valid_move?(p)).to eq(false)
    end
  end
end
