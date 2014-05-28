class Firm < ActiveRecord::Base
  has_many :rounds
  has_many :shareholders
  has_many :investments
  belongs_to :user

  validates_presence_of :name, :initial_capital


end
