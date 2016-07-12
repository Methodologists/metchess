class RemoveCheckFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :check
  end
end
