class AddInitialInvestorToShareholders < ActiveRecord::Migration
  def change
    add_column :shareholders, :initial_investor, :boolean, default: false
  end
end
