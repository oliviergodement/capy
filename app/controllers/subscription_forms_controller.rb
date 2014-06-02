class SubscriptionFormsController < ApplicationController

  def index
    @firm = Firm.find(params[:id])
    @round = Round.find(params[:round_id])
  end

  def show
    @firm = Firm.find(params[:id])
    @round = Round.find(params[:round_id])
    @investment = Investment.find(params[:investment_id])
    @shareholder = Shareholder.find(params[:shareholder_id])
  end


end
