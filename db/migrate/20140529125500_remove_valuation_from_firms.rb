class RemoveValuationFromFirms < ActiveRecord::Migration
  def change
    remove_column :firms, :valuation, :decimal
    add_column :firms, :pre_valuation, :decimal, precision: 15, scale: 7
    add_column :firms, :post_valuation, :decimal, precision: 15, scale: 7
  end
end
