class AddRoundIdToInvestment < ActiveRecord::Migration
  def change
    add_column :investments, :round_id, :integer
  end
end
