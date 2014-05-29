class Investment < ActiveRecord::Base
  belongs_to :firm
  belongs_to :shareholder
  belongs_to :round

  # after_create :update_round

  # def update_round
  #   round.amount_raised += self.amount
  #   round.save
  # end
end
