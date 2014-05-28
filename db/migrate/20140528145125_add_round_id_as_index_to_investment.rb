class AddRoundIdAsIndexToInvestment < ActiveRecord::Migration
  def change
    add_index :investments, :round_id
  end
end
