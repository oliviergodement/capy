class Firm < ActiveRecord::Base
  has_many :rounds
  has_many :shareholders
  belongs_to :user
end
