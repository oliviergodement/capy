class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.float :amount
      t.references :firm, index: true
      t.references :shareholder, index: true

      t.timestamps
    end
  end
end
