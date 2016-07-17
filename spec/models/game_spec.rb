require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'game#create' do
    xit 'adds to the database' do
      Game.create
      expect(Game.count).to eq(1)
    end

    xit 'creates all 32 pieces' do
      Game.create
      expect(Pawn.count).to eq(16)
      expect(King.count).to eq(2)
      expect(Queen.count).to eq(2)
      expect(Bishop.count).to eq(4)
      expect(Knight.count).to eq(4)
      expect(Rook.count).to eq(4)
    end
  end

  describe 'turn logic' do
    it 'makes first turn white player' do
      game = FactoryGirl.create(:game)
      expect(game.current_turn).to eq("white")
    end

    it 'switches turn color after move is made' do
      game = FactoryGirl.create(:game)
      piece = game.pieces.where(type: "Pawn", x_cord: 0, y_cord: 1).first
      piece.move_to!(0, 2)
      game.reload
      expect(game.current_turn).to eq("black")
    end
  end
end
