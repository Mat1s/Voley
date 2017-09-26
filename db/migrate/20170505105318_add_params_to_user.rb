class AddParamsToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :image
    end
  end
end
