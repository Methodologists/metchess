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

  describe '#checkmate?' do
    it 'should return true if white king is in checkmate' do
      g = Game.create(id: 1)
      Piece.destroy_all(game_id: g.id)
      King.create(color:"white", x_cord: 7, y_cord: 7, game_id: g.id)
      Knight.create(color: "black", x_cord: 7, y_cord: 2, game_id: g.id)
      King.create(color:"black", x_cord: 6, y_cord: 2, game_id: g.id)
      Bishop.create(color:"black", x_cord: 5, y_cord: 2, game_id: g.id)
      expect(g.checkmate?).to eq true
    end

    it 'should return false if both kings are not in checkmate' do
      g = Game.create(id: 1)
      expect(g.checkmate?).to eq false
    end 
  end

  describe '#set_first_turn' do
    it 'makes first turn white player' do
      game = Game.create
      expect(game.current_turn).to eq("white")
    end

    describe '#next_turn' do
      let(:game) { Game.create }
      
      before { game.update(current_turn: color) }

      context 'when the current turn is white' do
        let(:color) { 'white' }

        it 'switches to black' do
          game.next_turn!
          game.reload
          expect(game.current_turn).to eq('black')
        end
      end

      context 'when the current turn is black' do
        let(:color) { 'black' }

        it 'switches to white' do
          game.next_turn!
          game.reload
          expect(game.current_turn).to eq('white')
        end
      end    
    end  
  end
end
