class RemoveFirmsIdFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :firms, index: true
  end
end
