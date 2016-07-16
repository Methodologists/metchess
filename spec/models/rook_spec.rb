require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "valid_move? action" do

    {
      [[0, 0], [0, 0]] => false, #can't move to same position
      [[0, 0], [7, 0]] => true, 
      [[0, 0], [0, 7]] => true, 
      [[7, 7], [0, 7]] => true, 
      [[7, 7], [7, 0]] => true, 
      [[0, 0], [-7, 7]] => false, #off board, wrong logic
      [[0, 0], [0, 10]] => false, #off board
      [[0, 0], [2, 1]] => false, #wrong logic
      [[3, 3], [nil, nil]] => false, # move to nil coordinates
      [[nil, nil], [0, 0]] => false, # move from nil coords        
      [[nil, nil], [nil, nil]] => false, # nil coords to nil coords

    }.each do |before_and_after_coords, result|
      it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
        rook = Rook.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
        expect(rook.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
      end
    end
  end
end
