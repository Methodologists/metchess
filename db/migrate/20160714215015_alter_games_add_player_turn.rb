class AlterGamesAddPlayerTurn < ActiveRecord::Migration
  def change
    add_column :games, :current_turn, :string
  end
end
