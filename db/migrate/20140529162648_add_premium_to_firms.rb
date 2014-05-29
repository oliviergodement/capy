class AddPremiumToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :premium, :decimal
  end
end
