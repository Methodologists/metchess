class ChangeMovedTypeInPieces < ActiveRecord::Migration
  def change
    change_column :pieces, :moved, 'boolean USING CAST(moved AS boolean)'
  end
end
