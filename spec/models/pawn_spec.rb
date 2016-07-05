require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move? action" do
    it "should check that position it's moving to exists" do
      p = Pawn.create(x_cord: 7, y_cord: 7)
      expect(p.valid_move?(7, 8)).to eq(false)
    end

    it "should check that Pawn is allowed to move diagonally" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'black')
      o = Pawn.create(x_cord: 1, y_cord: 2, color: 'white')
      expect(p.valid_move?(1, 2)).to eq(true)
    end

    it "should check that Pawn moves 2 squares on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 1)
      expect(p.valid_move?(0, 3)).to eq(true)
    end

    it "should check that Pawn doesn't move more than 2 squares when on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 1)
      expect(p.valid_move?(0, 4)).to eq(false)
    end

    it "should check that Pawn doesn't move 2 squares when it's not on first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 2)
      expect(p.valid_move?(0, 4)).to eq(false)
    end
  end
end
