class RemoveColumnFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :reset_digest_at, :datetime
    remove_column :users, :create_at, :datetime
    remove_column :users, :update_at, :datetime
    add_column :users, :reset_password_at, :datetime
  end
end
