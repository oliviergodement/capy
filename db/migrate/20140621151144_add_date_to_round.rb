class AddDateToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :date, :datetime
  end
end
