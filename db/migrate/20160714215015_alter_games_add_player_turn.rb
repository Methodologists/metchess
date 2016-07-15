class AlterGamesAddPlayerTurn < ActiveRecord::Migration
  def change
    add_column :games, :player_turn, :integer
  end
end
