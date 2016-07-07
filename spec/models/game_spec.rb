require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'game#create' do
    it 'adds to the database' do
      Game.create
      expect(Game.count).to eq(1)
    end

    it 'creates all 32 pieces' do
      Game.create
      expect(Pawn.count).to eq(16)
      expect(King.count).to eq(2)
      expect(Queen.count).to eq(2)
      expect(Bishop.count).to eq(4)
      expect(Knight.count).to eq(4)
      expect(Rook.count).to eq(4)
    end
  end

  describe '#check?' do
    it 'checks coordinates for white king' do
      g = Game.create
      expect(g.check?.x_cord).to eq 4
      expect(g.check?.y_cord).to eq 0
    end

    it 'checks if king is not in check' do
      g= Game.create
      expect(g.check?).to eq false
    end
  end
end
