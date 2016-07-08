require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'games#create action' do

    it "should require users to be logged in" do
      post :create, game: {name: 'Testgame'}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a game in the database"
      user = FactoryGirl.create(:user)
    end


    it "should redirect to game page after creation" do
      put :update, game_id: game.id, id: piece.id, piece: {x_cord: 0, y_cord: 2}
      expect(response).to have_http_status(:redirect)
    end

    it "should add the current user as white player when creating game" do
      put :update, game_id: game.id, id: piece.id, piece: {x_cord: 0, y_cord: 2}
      piece.reload
      expect(piece.x_cord).to eq(0)
      expect(piece.y_cord).to eq(2)
    end

  end
end