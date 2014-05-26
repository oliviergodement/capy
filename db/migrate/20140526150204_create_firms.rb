class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.text :name
      t.decimal :initial_capital
      t.integer :shares
      t.decimal :valuation
      t.text :official_address
      t.text :rcs
      t.text :court_service
      t.text :bank_name
      t.text :bank_agency
      t.text :bank_agency_address
      t.text :bank_account
      t.decimal :share_price

      t.timestamps
    end
  end
end
