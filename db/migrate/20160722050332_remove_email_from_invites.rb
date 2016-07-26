class RemoveEmailFromInvites < ActiveRecord::Migration
  def change
    remove_column :invites, :email
  end
end
