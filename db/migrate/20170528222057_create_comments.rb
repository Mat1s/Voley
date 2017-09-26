class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :pcomment, polymorphic: true
      t.integer :number_nesting, default: 0
      t.integer :user_id, null: false
      t.text    :body, limit: 500
      t.boolean :deleted, default: false
      t.references :parent, index: true
      
      t.datetime :deleted_at
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
    end
  end
end
