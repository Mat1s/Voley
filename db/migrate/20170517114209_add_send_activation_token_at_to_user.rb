class AddSendActivationTokenAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :send_activation_token_at, :datetime
  end
end
