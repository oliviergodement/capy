class AddRealValueToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :real_value, :decimal, precision: 10, scale: 3
  end
end
