class CreateShareholders < ActiveRecord::Migration
  def change
    create_table :shareholders do |t|
      t.text :first_name
      t.text :last_name
      t.date :birth_date
      t.string :email, default: ""
      t.string :address
      t.string :nationality
      t.boolean :founder, default: false
      t.decimal :ownership
      t.integer :shares
      t.decimal :initial_ownership, default: 0
      t.references :firm, index: true

      t.timestamps
    end
  end
end
