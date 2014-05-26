class AddValuationAndSharePriceAndInitialCapitalToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :valuation, :decimal, precision: 10, scale: 3
    add_column :firms, :share_price, :decimal, precision: 10, scale: 3
    add_column :firms, :initial_capital, :decimal, precision: 10, scale: 3
  end
end