require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe "#valid_move?" do

    {
      #starting at edge of board
      [[0, 0], [0, 0]] => false, #can't move to same position
      [[0, 0], [7, 7]] => true, #can move diagonally
      [[0, 0], [0, 7]] => true, #can move left & right
      [[0, 0], [-7, 7]] => false, #on board
      [[3, 3], [4, 5]] => false, #wrong logic
      [[0, 0], [0, 10]] => false, #can move left & right
      [[0, 0], [7, 0]] => true, #can move up & down
      [[0, 0], [2, 1]] => false, #can't do knight move
      [[3, 3], [nil, nil]] => false, # move to nil coordinates
      [[nil, nil], [0, 0]] => false, # move from nil coords        
      [[nil, nil], [nil, nil]] => false, # nil coords to nil coords

    }.each do |before_and_after_coords, result|
      it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
        queen = Queen.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
        expect(queen.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
      end
    end
  end
end
