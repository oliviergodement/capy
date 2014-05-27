class AddNominalValueToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :nominal_value, :decimal, precision: 10, scale: 3
  end
end
