class AddCorrectedSharesToShareholders < ActiveRecord::Migration
  def change
    add_column :shareholders, :corrected_shares, :integer
  end
end
