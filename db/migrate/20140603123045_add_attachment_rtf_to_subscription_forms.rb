class AddAttachmentRtfToSubscriptionForms < ActiveRecord::Migration
  def self.up
    change_table :subscription_forms do |t|
      t.attachment :rtf
    end
  end

  def self.down
    drop_attached_file :subscription_forms, :rtf
  end
end
