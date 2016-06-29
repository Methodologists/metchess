require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move?" do
    it "should check that the position the king is moving to exists" do
      k = King.create(x_cord: 0, y_cord: 0)
      expect(k.valid_move?(-1, 0)).to eq(false)
    end

    it "should check that the position the king is moving to is allowed by the King's piece rules" do
      k = King.create(x_cord: 0, y_cord: 0)
      expect(k.valid_move?(0, 2)).to eq(false)
    end
  end
end
