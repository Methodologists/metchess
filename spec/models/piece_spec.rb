require 'rails_helper'
 
RSpec.describe Piece, type: :model do
  describe "#is_obstructed" do


    context "when moving horizontally" do      
      it "returns false if moving only 1 space -- nothing in between to check" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        expect(rook.is_obstructed?(1,0)).to eq false
      end

      it "returns true if something is in the way in between to the right" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        expect(rook.is_obstructed?(5,0)).to eq true
      end

      it "returns true if something is in the way in between to the left" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 7, y_cord: 0)
        expect(rook.is_obstructed?(1,0)).to eq true
      end

      it "returns false if path clear and there is no obstruction" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        rook.update(x_cord: 0, y_cord: 2)
        rook.reload
        expect(rook.is_obstructed?(4,2)).to eq false
      end
    end

    context "when moving vertically" do
      it "returns false if moving only 1 space -- nothing in between to check" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        expect(rook.is_obstructed?(0,1)).to eq false
      end

      it "returns true if something is in the way in between moving up" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        expect(rook.is_obstructed?(0,3)).to eq true
      end

      it "returns true if something is in the way in between moving down" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 7, y_cord: 7)
        expect(rook.is_obstructed?(7,4)).to eq true
      end

      it "returns false if path clear and there is no obstruction" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        rook.update(x_cord: 0, y_cord: 2)
        rook.reload
        expect(rook.is_obstructed?(0,4)).to eq false
      end
    end

    context "when moving diagonally (graph y=x)" do
      it "returns false if moving only 1 space -- nothing in between to check" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 2, y_cord: 0)
        expect(bishop.is_obstructed?(3,1)).to eq false
      end

      it "returns true if something is in the way in between moving up" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 2, y_cord: 0)
        expect(bishop.is_obstructed?(5,3)).to eq true
      end

      it "returns true if something is in the way in between moving down" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 5, y_cord: 7)
        expect(bishop.is_obstructed?(0,2)).to eq true
      end

      it "returns false if path clear and there is no obstruction" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 2, y_cord: 0)
        bishop.update(x_cord: 3, y_cord: 5)
        bishop.reload
        expect(bishop.is_obstructed?(0,2)).to eq false
      end
    end

    context "when moving diagonally (graph y= -x)" do
      it "returns false if moving only 1 space -- nothing in between to check" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 5, y_cord: 0)
        expect(bishop.is_obstructed?(4,1)).to eq false
      end

      it "returns true if something is in the way in between moving up" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 5, y_cord: 0)
        expect(bishop.is_obstructed?(2,3)).to eq true
      end

      it "returns true if something is in the way in between moving down" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 2, y_cord: 7)
        expect(bishop.is_obstructed?(7,2)).to eq true
      end

      it "returns false if path clear and there is no obstruction" do
        game1= Game.create(id: 1)
        bishop = Piece.find_by(type: "Bishop", x_cord: 5, y_cord: 0)
        bishop.update(x_cord: 3, y_cord: 2)
        bishop.reload
        expect(bishop.is_obstructed?(5,4)).to eq false
      end
    end

  end

  describe "#move_to!" do
    context "when another piece is on the new spot" do
      it "captures it by updating its coords to nil" do
        game1 = Game.create(id: 1)
        black_pawn = Piece.find_by(type:"Pawn", color: "black", x_cord: 2, y_cord: 6)
        black_pawn.update(x_cord: 2, y_cord: 2)
        white_pawn = Piece.find_by(type:"Pawn", color: "white", x_cord: 2, y_cord: 1)
        white_pawn.move_to!(2, 2)
        black_pawn.reload
        white_pawn.reload
        expect(black_pawn.x_cord).to be_nil
        expect(black_pawn.y_cord).to be_nil
      end

      it "does not update own coords if other piece is a friend" do
        game1 = Game.create(id: 1)
        piece1 = Piece.create(x_cord: 0, y_cord: 0, color: "white", game_id: 1)
        piece2 = Piece.create(x_cord: 1, y_cord: 1, color: "white", game_id: 1)
        piece1.move_to!(1, 1)        
        piece1.reload
        piece2.reload

        # piece1 doesn't move
        expect(piece1.x_cord).to eq 0
        expect(piece1.y_cord).to eq 0

        # piece2 still on the board
        expect(piece2.x_cord).to eq 1
        expect(piece2.y_cord).to eq 1
      end

      it "does not update piece cords in other games" do
        game1 = Game.create(id: 1)
        game2 = Game.create(id: 2)
        piece1 = Piece.create(x_cord: 0, y_cord: 0, color: "white", game_id: 1)
        piece2 = Piece.create(x_cord: 1, y_cord: 1, color: "black", game_id: 2)
        piece1.move_to!(1, 1)
        piece1.reload
        piece2.reload
        expect(piece2.x_cord).to eq 1
        expect(piece2.y_cord).to eq 1
      end
    end

    context "when no piece on the new spot" do
      it "updates the x and y coords of the piece" do
        game1 = Game.create(id: 1)
        piece = Piece.create(x_cord: 0, y_cord: 0, game_id: 1)
        piece.move_to!(1, 1)
        expect(piece.x_cord).to eq 1
        expect(piece.y_cord).to eq 1
      end
    end

    context 'when castling' do
      it 'should unsuccessfully short castle' do
        g = Game.create(id: 1)
        king = Piece.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Piece.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        king.move_to!(6, 0)
        king.reload
        rook.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.x_cord).to eq 7
        expect(rook.y_cord).to eq 0
      end

      it 'should unsuccessfully long castle' do
        g = Game.create(id: 1)
        king = Piece.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Piece.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        king.reload
        rook.reload
        expect(king.x_cord).to eq 4
        expect(king.y_cord).to eq 0
        expect(rook.x_cord).to eq 0
        expect(rook.y_cord).to eq 0
      end

      it 'should successfully short castle' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 5, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 6, y_cord: 0, game_id: g.id).destroy_all
        king = Piece.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Piece.find_by(x_cord: 7, y_cord: 0, game_id: g.id)
        king.move_to!(6, 0)
        king.reload
        rook.reload
        expect(king.x_cord).to eq 6
        expect(king.y_cord).to eq 0
        expect(rook.x_cord).to eq 5
        expect(rook.y_cord).to eq 0
      end

      it 'should successfully long castle' do
        g = Game.create(id: 1)
        Piece.where(x_cord: 3, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 2, y_cord: 0, game_id: g.id).destroy_all
        Piece.where(x_cord: 1, y_cord: 0, game_id: g.id).destroy_all
        king = Piece.find_by(x_cord: 4, y_cord: 0, game_id: g.id)
        rook = Piece.find_by(x_cord: 0, y_cord: 0, game_id: g.id)
        king.move_to!(2, 0)
        king.reload
        rook.reload
        expect(king.x_cord).to eq 2
        expect(king.y_cord).to eq 0
        expect(rook.x_cord).to eq 3
        expect(rook.y_cord).to eq 0
      end
    end
  end
end