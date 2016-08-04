class AddCastleMovedColumnToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :castle_moved, :boolean
  end
end
