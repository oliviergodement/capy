class AddSharesToShareholders < ActiveRecord::Migration
  def change
    add_column :shareholders, :shares, :float
  end
end
