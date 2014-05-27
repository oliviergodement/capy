class RemoveNominalValueFromFirms < ActiveRecord::Migration
  def change
    remove_column :firms, :nominal_value, :decimal
  end
end
