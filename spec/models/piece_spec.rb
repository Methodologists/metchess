require 'rails_helper'
 
RSpec.describe Piece, type: :model do
  describe "#is_obstructed" do


    context "when moving horizontally" do      
      it "returns true if something is in the way" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        expect(rook.is_obstructed?(5,0)).to eq true
      end

      it "returns false if path clear and there is no obstruction" do
        game1= Game.create(id: 1)
        rook = Piece.find_by(type: "Rook", x_cord: 0, y_cord: 0)
        rook.update(x_cord: 0, y_cord: 2)
        rook.reload
        expect(rook.is_obstructed?(4,2)).to eq false
      end
    end

    context "when moving vertically"
    context "when moving diagonally up (graph y=x)"
    context "when moving diagonally down (graph y=-x)"
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
  end


end