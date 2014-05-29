class AddInitialRoundToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :initial_round, :boolean
  end
end
