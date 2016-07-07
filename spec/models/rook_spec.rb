require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "valid_move? action" do
    it "should check that position rook is moving to exists" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(-5, 0)).to eq(false)
    end

    it "should check that rook moves horizontally to the right" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(7, 0)).to eq(true)
    end

    it "should check that rook moves vertically upwards" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(0, 7)).to eq(true)
    end

    it "should check that rook doesn't move like a knight" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(1, 2)).to eq(false)
    end

    it "should check that rook doesn't move like a bishop" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(7, 7)).to eq(false)
    end

    it "should check that rook doesn't blatantly break rules" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(2, 7)).to eq(false)
    end

    it "should check that rook moves vertically downwards" do
      r = Rook.create(x_cord: 7, y_cord: 7)
      expect(r.valid_move?(7, 0)).to eq(true)
    end

    it "should check that rook moves horizontally to the left" do
      r = Rook.create(x_cord: 7, y_cord: 0)
      expect(r.valid_move?(0, 0)).to eq(true)
    end

    it "should check that rook isn't allowed to move to the same spot" do
      r = Rook.create(x_cord: 0, y_cord: 0)
      expect(r.valid_move?(0,0)).to eq(false)
    end
  end
end
