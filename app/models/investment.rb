class Investment < ActiveRecord::Base
  belongs_to :firm
  belongs_to :shareholder
  belongs_to :round
  has_one :subscription_form

end
