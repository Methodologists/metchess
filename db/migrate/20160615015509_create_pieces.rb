class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :piece_id
      t.integer :game_id
      t.string :color
      t.integer :y_cord
      t.integer :x_cord
      
      t.timestamps
    end
  end
end
