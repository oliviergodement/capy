class Shareholder < ActiveRecord::Base
  belongs_to :firm
  has_many :investments
end
