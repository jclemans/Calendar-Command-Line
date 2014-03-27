class EditTimes < ActiveRecord::Migration
  def change
    remove_column :events, :start, :datetime
    remove_column :events, :end, :datetime
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
  end
end
