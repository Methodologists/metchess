class AddColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :checkmate, :boolean
  end
end
