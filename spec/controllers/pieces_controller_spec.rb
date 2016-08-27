
require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  let(:user){FactoryGirl.create(:user)}
  let(:game){Game.create(white_player: user, black_player: user)}
  let(:piece){Pawn.find_by(x_cord: 0, y_cord: 1, game_id: game.id, color: "white")}

  before { sign_in user }

  describe '#update' do
    it "should redirect after update" do
      put :update, game_id: game.id, id: piece.id, piece: {new_x: 0, new_y: 2}
      expect(response).to have_http_status(:redirect)
    end

    it "should update piece location" do
      put :update, game_id: game.id, id: piece.id, piece: {new_x: 0, new_y: 2}
      piece.reload
      expect(piece.x_cord).to eq(0)
      expect(piece.y_cord).to eq(2)
    end

    it "should error if not my piece" do
      black_pawn = Pawn.find_by(x_cord: 0, y_cord: 6, game_id: game.id, color: "black")
      put :update, game_id: game.id, id: black_pawn.id, piece: {new_x: 0, new_y: 5}
      expect(flash[:alert]).to match "It's not your turn, you barnacle!"
    end

    it "should error if not my piece" do
      game.update(current_turn: "black")
      put :update, game_id: game.id, id: piece.id, piece: {new_x: 0, new_y: 2}
      expect(flash[:alert]).to match "It's not your turn, you barnacle!"
    end


    it "should error if obstructed" do
      rook = Rook.find_by(x_cord: 0, y_cord: 0, game_id: game.id, color: "white")
      put :update, game_id: game.id, id: rook.id, piece: {new_x: 0, new_y: 2}
      expect(flash[:alert]).to match "Sorry, can't move there"
    end

    it "should error if not valid move" do
      put :update, game_id: game.id, id: piece.id, piece: {new_x: 0, new_y: 5}
      expect(flash[:alert]).to match "Sorry, can't move there"
    end
  end

end