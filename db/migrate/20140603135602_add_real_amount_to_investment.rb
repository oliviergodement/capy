class AddRealAmountToInvestment < ActiveRecord::Migration
  def change
    add_column :investments, :real_amount, :decimal, precision: 15, scale: 7
  end
end
