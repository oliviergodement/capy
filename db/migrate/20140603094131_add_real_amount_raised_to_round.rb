class AddRealAmountRaisedToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :real_amount_raised, :decimal, precision: 15, scale: 7
  end
end
