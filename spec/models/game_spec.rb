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
    it 'should return true if either king is in check' do
      g = Game.create
      k = King.find_by(color: 'black', game_id: g.id)
      k.update(x_cord: 0, y_cord: 3)
      r = Rook.find_by(color: 'white', game_id: g.id)
      r.update(x_cord: 4, y_cord: 3)
      expect(g.check?).to eq true
    end

    it 'should return false if white king is in path of white rook' do
      g = Game.create
      p = Piece.where(color: 'black', game_id: g.id)
      p.each do |piece|
        piece.update(x_cord: nil, y_cord: nil)
      end
      k = King.find_by(color: 'white', game_id: g.id)
      k.update(x_cord: 5, y_cord: 3)
      r = Rook.find_by(color: 'white', game_id: g.id)
      r.update(x_cord: 4, y_cord: 3)
      expect(g.check?).to eq false
    end
  end
end
