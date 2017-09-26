class AddTimeEventToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :time_event, :datetime
  end
end
