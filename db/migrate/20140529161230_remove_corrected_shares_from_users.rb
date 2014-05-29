class RemoveCorrectedSharesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :corrected_shares, :integer
  end
end
