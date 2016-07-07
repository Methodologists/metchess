require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "#move_to!" do
    context "when another piece is on the new spot" do
      it "captures it by updating its coords to nil" do
        piece1 = Piece.create(x_cord: 0, y_cord: 0, color: "white", game_id: 1)
        piece2 = Piece.create(x_cord: 1, y_cord: 1, color: "black", game_id: 1)
        piece1.move_to!(1, 1)
        piece1.reload
        piece2.reload
        expect(piece2.x_cord).to be_nil
        expect(piece2.y_cord).to be_nil
      end

      it "does not update own coords if other piece is a friend" do
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
        piece = Piece.create(x_cord: 0, y_cord: 0)
        piece.move_to!(1, 1)
        expect(piece.x_cord).to eq 1
        expect(piece.y_cord).to eq 1
      end
    end

    describe '#check?' do
      it 'checks if king moves into check position' do
        k = King.create(x_cord: 1, y_cord: 2, color: 'white')
        q = Queen.create(x_cord: 0, y_cord: 0, color: 'black')
        k.update(x_cord: 0, y_cord: 2)
        expect(k.check?).to eq true
      end

      it 'checks if'
    end
  end
end