class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.decimal :amount_raised
      t.decimal :ownership_offered
      t.text :name
      t.references :firm, index: true

      t.timestamps
    end
  end
end
