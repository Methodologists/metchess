class AddCastleMovedTimeToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :castle_moved_time, :datetime
  end
end
