class AddMovedColumnToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :moved, :string
  end
end
