class RemoveValuationAndSharePriceAndInitialCapitalFromFirms < ActiveRecord::Migration
  def change
    remove_column :firms, :valuation, :decimal
    remove_column :firms, :share_price, :decimal
    remove_column :firms, :initial_capital, :decimal
  end
end
