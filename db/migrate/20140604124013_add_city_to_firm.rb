class AddCityToFirm < ActiveRecord::Migration
  def change
    add_column :firms, :city, :string
    add_column :firms, :country, :string
    add_column :firms, :postal_code, :string
  end
end
