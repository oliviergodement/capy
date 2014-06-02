class Round < ActiveRecord::Base
  belongs_to :firm
  has_many :investments
  has_many :shareholders, through: :investments
  has_many :subscription_forms
end
