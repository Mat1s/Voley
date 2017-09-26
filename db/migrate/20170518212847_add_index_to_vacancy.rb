class AddIndexToVacancy < ActiveRecord::Migration[5.0]
  def change
  	change_table :vacancies do |t|
  	  t.index([:user_id, :game_id], unique: true) 
  	end
  end
end
