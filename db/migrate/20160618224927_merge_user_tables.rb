class MergeUserTables < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :integer
    add_column :users, :name, :string
  end
end
