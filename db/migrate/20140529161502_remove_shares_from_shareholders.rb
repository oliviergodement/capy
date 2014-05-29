class RemoveSharesFromShareholders < ActiveRecord::Migration
  def change
    remove_column :shareholders, :shares, :integer
  end
end
