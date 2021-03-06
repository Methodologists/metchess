require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "#valid_move?" do
    it "should check that pawn can't move to same position" do
      p = Pawn.create(x_cord: 1, y_cord: 1)
      expect(p.valid_move?(1, 1)).to eq false
    end
    it "should check that position it's moving to exists" do
      p = Pawn.create(x_cord: 7, y_cord: 7)
      expect(p.valid_move?(7, 8)).to eq(false)
    end

    it "should check that Pawn is allowed to move diagonally when capturing" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'white')
      o = Pawn.create(x_cord: 1, y_cord: 2, color: 'black')
      expect(p.valid_move?(1, 2)).to eq(true)
    end

    it "should check that Pawn cannot move diagonally when pieces are same color" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'white')
      o = Pawn.create(x_cord: 1, y_cord: 2, color: 'white')
      expect(p.valid_move?(1, 2)).to eq(false)
    end

    it "should check that white Pawn can move 2 squares on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'white')
      expect(p.valid_move?(0, 3)).to eq(true)
    end

    it "should check that black Pawn can move 2 squares on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 6, color: 'black')
      expect(p.valid_move?(0, 4)).to eq(true)
    end

    it "should check that white Pawn can't move more than 2 squares when on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'white')
      expect(p.valid_move?(0, 4)).to eq(false)
    end

    it "should check that black Pawn can't move more than 2 squares when on its first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 6, color: 'black')
      expect(p.valid_move?(0, 3)).to eq(false)
    end

    it "should check that white Pawn can't move 2 squares when its not on first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 2, color: 'white')
      expect(p.valid_move?(0, 4)).to eq(false)
    end

    it "should check that white Pawn can't move 2 squares when reaching black first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 6, color: 'white')
      expect(p.valid_move?(0, 4)).to eq(false)
    end

    it "should check that black Pawn can't move 2 squares when reaching white first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 1, color: 'black')
      expect(p.valid_move?(0, 3)).to eq(false)
    end

    it "should check that black Pawn can't move 2 squares when its not on first move position" do
      p = Pawn.create(x_cord: 0, y_cord: 5, color: 'black')
      expect(p.valid_move?(0, 3)).to eq(false)
    end

    it "should check that white Pawn can't move backwards" do
      p = Pawn.create(x_cord: 0, y_cord: 3, color: 'white')
      expect(p.valid_move?(0, 2)).to eq(false)
    end

    it "should check that black Pawn can't move backwards" do
      p = Pawn.create(x_cord: 0, y_cord: 4, color: 'black') 
      expect(p.valid_move?(0, 5)).to eq(false)
    end

    it "should check that Pawn doesn't move like Knight" do
      p = Pawn.create(x_cord: 0, y_cord: 0)
      expect(p.valid_move?(1, 2)).to eq(false)
    end

    it "should check that Pawn doesn't move like Rook vertically upward" do
      p = Pawn.create(x_cord: 0, y_cord: 0)
      expect(p.valid_move?(0, 7)).to eq(false)
    end

    it "should check that Pawn doesn't move like Rook horizontally to the left" do
      p = Pawn.create(x_cord: 7, y_cord: 0)
      expect(p.valid_move?(0, 0)).to eq(false)
    end

    it "should check that Pawn doesn't move like Rook horizontally to the right" do
      p = Pawn.create(x_cord: 0, y_cord: 0)
      expect(p.valid_move?(7, 0)).to eq(false)
    end

    it "should check that Pawn doesn't move like bishop" do
      p = Pawn.create(x_cord: 0, y_cord: 0)
      expect(p.valid_move?(7, 7)).to eq(false)
    end

    it "should check that Pawn doesn't move backwards diagonally" do
      p = Pawn.create(x_cord: 1, y_cord: 1, color: 'white')
      expect(p.valid_move?(0, 0)).to eq(false)
    end
  end
end
