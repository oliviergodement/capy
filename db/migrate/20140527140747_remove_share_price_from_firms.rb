class RemoveSharePriceFromFirms < ActiveRecord::Migration
  def change
    remove_column :firms, :share_price, :decimal
  end
end
