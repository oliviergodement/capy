class AddGenderToShareholder < ActiveRecord::Migration
  def change
    add_column :shareholders, :gender, :string
  end
end
