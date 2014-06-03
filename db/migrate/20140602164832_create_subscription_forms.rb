class CreateSubscriptionForms < ActiveRecord::Migration
  def change
    create_table :subscription_forms do |t|
      t.references :investment, index: true
      t.references :shareholder, index: true
      t.references :round, index: true
      t.references :firm, index: true

      t.timestamps
    end
  end
end
