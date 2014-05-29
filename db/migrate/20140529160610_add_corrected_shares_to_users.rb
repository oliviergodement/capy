class AddCorrectedSharesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :corrected_shares, :integer
  end
end
