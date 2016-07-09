class AddCheckToGames < ActiveRecord::Migration
  def change
    add_column :games, :check, :string 
  end
end
