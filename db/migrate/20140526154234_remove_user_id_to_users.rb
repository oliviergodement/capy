class RemoveUserIdToUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :user, index: true
  end
end
