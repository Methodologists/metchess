require 'rails_helper'

RSpec.describe Knight, type: :model do

  describe "#valid_move?" do

      {
        #starting at edge of board
        [[0, 0], [1, 2]] => true,
        [[0, 0], [1, -2]] => false, # off-board
        [[0, 0], [2, 1]] => true, 
        [[0, 0], [2, -1]] => false, # off-board
        [[0, 0], [0, 0]] => false, # no move, wrong logic
        
        #starting at center of board
        [[3, 3], [1, 2]] => true,
        [[3, 3], [1, 4]] => true,
        [[3, 3], [5, 2]] => true,
        [[3, 3], [5, 4]] => true,
        [[3, 3], [4, 1]] => true,
        [[3, 3], [4, 5]] => true,
        [[3, 3], [2, 1]] => true,
        [[3, 3], [2, 5]] => true,
        [[3, 3], [1, 1]] => false, # wrong logic
        [[3, 3], [0, 0]] => false, # wrong logic
        [[3, 3], [-1, -1]] => false, # wrong logic & off-board
      }.each do |before_and_after_coords, result|
        it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
          knight = Knight.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
          expect(knight.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
        end
      end
  end
end
