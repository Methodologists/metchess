require 'rails_helper'

RSpec.describe King, type: :model do

    describe "#valid_move?" do
      it "should return false if the king is moving into check position" do
        king = King.create(x_cord: 0, y_cord: 0, color: 'black', game_id: 1)
        rook = Rook.create(x_cord: 1, y_cord: 7, color: 'white', game_id: 1)
        expect(king.valid_move?(1,0)).to eq false
      end

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
        [[1, 1], [nil, nil]] => false, # moving to nil coords
        [[nil, nil], [nil, nil]] => false, # nil coords to nil coords
        
      }.each do |before_and_after_coords, result|
        it "returns #{result} when moving from #{before_and_after_coords.first} to #{before_and_after_coords.last}" do
          king = King.create(x_cord: before_and_after_coords.first.first, y_cord: before_and_after_coords.first.last)
          expect(king.valid_move?(before_and_after_coords.last.first, before_and_after_coords.last.last)).to eq result
      end
    end

    it 'should return false if king moves next to other king' do
      g = Game.create(id: 1)
      Piece.destroy_all
      k1 = King.create(game_id: g.id, color: "white", x_cord: 7, y_cord: 0)
      k2 = King.create(game_id: g.id, color: "black", x_cord: 5, y_cord: 2)
      expect(k1.valid_move?(6, 1)).to eq false
    end
  end
end
