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

    describe '#move_to!' do
      it 'should successfully short castle' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 5, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 6, y_cord: 0, game_id: g.id).destroy_all
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        king.move_to!(6, 0)
        king.reload
        rook = Piece.find_by(x_cord: 5, y_cord: 0, game_id: g.id)
        expect(king.x_cord).to eq 6
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 5
      end

      it 'should successfully long castle' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 3, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 2, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 1, y_cord: 0, game_id: g.id).destroy_all
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        rook.reload
        king.reload
        expect(king.x_cord).to eq 2
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 3
      end

      it 'should unsuccessfully long castle when 3 pieces in the way' do
        g = Game.create(id: 1)
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        rook.reload
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 0
      end

      it 'should unsuccessfully long castle when only 1 pieces in the way' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 3, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 2, y_cord: 0, game_id: g.id).destroy_all
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        rook.reload
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 0
      end

      it 'should unsuccessfully long castle when only 2 piece in the way' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 3, y_cord: 0, game_id: g.id).destroy_all
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        rook.reload
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 0
      end

      it 'should unsuccessfully short castle when 2 pieces in the way' do
        g = Game.create(id: 1)
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        king.move_to!(6, 0)
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 7
      end

      it 'should unsuccessfully short castle when only 1 piece in the way' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 5, y_cord: 0, game_id: g.id).destroy_all
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        king.move_to!(6, 0)
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 7
      end

      it 'should unsuccessfully short castle when king has moved already' do
        g = Game.create(id: 1)
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        king.update(castle_moved: true)
        Piece.where(x_cord: 5, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 6, y_cord: 0, game_id: g.id).destroy_all
        king.move_to!(6,0)
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 7
      end

      it 'should unsuccessfully long castle when king has moved already' do
        g = Game.create(id: 1)
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.update(castle_moved: true)
        Piece.where(x_cord: 1, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 2, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 3, y_cord: 0, game_id: g.id).destroy_all
        king.move_to!(2,0)
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 0
      end

      it 'should unsuccessfully short castle when king is in check' do
        g = Game.create(id: 1)
        king = King.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Rook.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        Piece.find_by(x_cord: 4, y_cord: 1, game_id: g.id).update(x_cord: nil, y_cord: nil)
        Queen.find_by(color: "black").update(x_cord: 4, y_cord: 4)
        Piece.where(x_cord: 5, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 6, y_cord: 0, game_id: g.id).destroy_all
        king.move_to!(6,0)
        king.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.y_cord).to eq 0
        expect(rook.x_cord).to eq 7
      end
    end
  end
end
