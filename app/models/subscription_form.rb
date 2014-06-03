class SubscriptionForm < ActiveRecord::Base
  belongs_to :investment
  belongs_to :shareholder
  belongs_to :round
  belongs_to :firm

  has_attached_file :rtf
end
