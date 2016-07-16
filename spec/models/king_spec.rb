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

    it "should make sure the king does not move like a knight" do
      k = King.create(x_cord: 1, y_cord: 1)
      expect(k.valid_move?(2, 3)).to eq(false)
    end

    it "should make sure the king does not move like a bishop" do
      k = King.create(x_cord: 1, y_cord: 1)
      expect(k.valid_move?(5, 5)).to eq(false)
    end

    it "should make sure the king does not move like a rook" do
      k = King.create(x_cord: 1, y_cord: 1)
      expect(k.valid_move?(1, 5)).to eq(false)
    end

    it "should make sure the king does not move like a rook" do
      k = King.create(x_cord: nil, y_cord: nil)
      expect(k.valid_move?(1, 5)).to eq(false)
    end
  end
end
