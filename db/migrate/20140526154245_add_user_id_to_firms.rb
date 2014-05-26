class AddUserIdToFirms < ActiveRecord::Migration
  def change
    add_reference :firms, :user, index: true
  end
end
