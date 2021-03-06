class Shareholder < ActiveRecord::Base
  belongs_to :firm
  has_many :investments
  has_many :rounds, through: :investments
  has_many :subscription_forms
end
