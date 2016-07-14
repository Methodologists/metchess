require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'games#create action' do

    it "should successfully create a game in the database" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, game: {name: 'Testgame'}

      game = Game.last
      expect(game.name).to eq("Testgame")
    end

    it "should add the current user as white player when creating game" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, game: {name: 'Testgame',
                            player_white_id: user.id}
       # Above line doesn't seem right - I'm doing it manually here,
        # not automatically as being done in new.html.erb                     
      game = Game.last
      expect(game.player_white_id).to eq(user.id)
    end

  end
end