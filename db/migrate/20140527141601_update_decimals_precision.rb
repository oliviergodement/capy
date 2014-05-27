class UpdateDecimalsPrecision < ActiveRecord::Migration
  def change
    remove_column :firms, :nominal_value, :decimal
    remove_column :firms, :real_value, :decimal
    remove_column :firms, :valuation, :decimal
    remove_column :firms, :initial_capital, :decimal
    add_column :firms, :nominal_value, :decimal, precision: 15, scale: 7
    add_column :firms, :real_value, :decimal, precision: 15, scale: 7
    add_column :firms, :valuation, :decimal, precision: 15, scale: 7
    add_column :firms, :initial_capital, :decimal, precision: 15, scale: 7
  end
end