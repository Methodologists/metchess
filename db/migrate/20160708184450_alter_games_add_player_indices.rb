class AlterGamesAddPlayerIndices < ActiveRecord::Migration
  def change
    add_index :games, :player_white_id
    add_index :games, :player_black_id
  end
end
