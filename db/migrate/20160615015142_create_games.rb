class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :game_id
      t.integer :player_white_id
      t.integer :player_black_id

      t.timestamps
    end
  end
end
