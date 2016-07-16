require 'rails_helper'

RSpec.describe King, type: :model do

    describe "#valid_move?" do

      {
        #starting at edge of board
        [[0, 0], [1, 1]] => true, # moves diagonal
        [[1, 1], [0, 1]] => true, # moves backwards
        [[1, 1], [1, 2]] => true, # moves forward        
        [[0, 0], [0, 0]] => false, # same position
        [[0, 0], [2, 2]] => false, # wrong logic
        [[0, 0], [2, -1]] => false, # off-board & wrong logic
        [[0, 0], [-1, -1]] => false, # off-board & right logic
        [[nil, nil], [1, 1]] => false, # if piece is not on board

      }.each do |before_and_after_coords, result|
        it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
          king = King.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
          expect(king.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
      end
    end
  end
end
