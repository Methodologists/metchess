require 'rails_helper'

RSpec.describe Bishop, type: :model do

  describe "#valid_move?" do

      {
        #starting at edge of board
        [[0, 0], [1, 1]] => true,
        [[0, 0], [0, 0]] => false, # same position
        [[0, 0], [1, 2]] => false, # wrong logic
        [[0, 0], [2, -1]] => false, # off-board
        [[0, 0], [6, 6]] => true,

      }.each do |before_and_after_coords, result|
        it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
          bishop = Bishop.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
          expect(bishop.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
        end
      end

    it "should check that initial bishop coordinates that are nil return false" do
      b = Bishop.create(x_cord: nil, y_cord: nil)
      expect(b.valid_move?(1, 1)).to eq false
    end

    it "should check that final bishop coordinates that are nil return false" do
      b = Bishop.create(x_cord: 0, y_cord: 0)
      expect(b.valid_move?(nil, nil)).to eq false
    end
  end

end