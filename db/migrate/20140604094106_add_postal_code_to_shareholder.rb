class AddPostalCodeToShareholder < ActiveRecord::Migration
  def change
    add_column :shareholders, :postal_code, :string
    add_column :shareholders, :city, :string
    add_column :shareholders, :country, :string
  end
end
