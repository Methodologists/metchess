class RemoveTokenFromInvites < ActiveRecord::Migration
  def change
    remove_column :invites, :token
  end
end
