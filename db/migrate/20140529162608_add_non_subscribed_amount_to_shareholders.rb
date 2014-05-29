class AddNonSubscribedAmountToShareholders < ActiveRecord::Migration
  def change
    add_column :shareholders, :non_subscribed_amount, :decimal
  end
end
