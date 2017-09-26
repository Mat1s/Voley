class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name, uniqueness: true, null: false
      t.integer :level, between: 0..7, default: 3
      t.string :city, null:false
      t.string :street, null: false
      t.integer :max_vacancies_for_players, null: false
      t.references :user, index: true

      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end

    create_table :vacancies do |t|
      t.belongs_to :game, index: true
      t.belongs_to :user, index: true

      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
    end
  end
end
