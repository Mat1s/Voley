class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.text :body, null: false 
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
      t.references :user_id, index:	true
    end
  end
end
