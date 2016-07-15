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
        [[0, 0], [7,]] => true, #can move up & down
        [[0, 0], [2, 1]] => false, #can't do knight move

      }.each do |before_and_after_coords, result|
        it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
          queen = Queen.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
          expect(queen.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
        end
      end

      it "should check that initial queen coordinates that are nil return false" do
        q = Queen.create(x_cord: nil, y_cord: nil)
        expect(q.valid_move?(0, 0)).to eq false
      end

      it "should check that final queen coordinates that are nil return false" do
        q = Queen.create(x_cord: 0, y_cord: 0)
        expect(q.valid_move?(nil, nil)).to eq false
      end
    end
end
