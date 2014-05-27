class User < ActiveRecord::Base
  has_many :firms
  validates_presence_of :age
end
