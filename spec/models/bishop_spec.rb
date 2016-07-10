require 'rails_helper'

RSpec.describe Pawn, type: :model do


  describe "valid move for Pawn piece" do

    it "should return false if move is out of the board" do
    	b = Bishop.create(x_cord:0, y_cord: 0)
      expect(b.valid_move?(2,10)).to eq false
    end


end