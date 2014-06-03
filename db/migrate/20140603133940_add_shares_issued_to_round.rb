class AddSharesIssuedToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :shares_issued, :integer
  end
end
