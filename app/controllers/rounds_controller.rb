class RoundsController < ApplicationController

  def new
    @round = Round.new
    @firm = Firm.find(params[:id])
  end

  def create
    @round = Round.create(round_params)
    @round.update_attribute(:initial_round, false)
    @firm = Firm.find(@round.firm_id)
    redirect_to new_shareholder_path(@firm.id, @round.id)
  end

  def show
    @round = Round.find(params[:round_id])
    @firm = Firm.find(params[:id])
  end

  def index
    @firm = Firm.find(params[:id])
    @rounds = @firm.rounds
  end

  def new_investments
    @firm = Firm.find(params[:id])
    @shareholder = Shareholder.new
  end

  def ownership
    @firm = Firm.find(params[:id])
    @round = Round.find(params[:round_id])
    @investments = Investment.find_by(firm_id: @firm.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def round_params
      params.require(:round).permit(:name, :ownership_offered, :firm_id)
    end

    def set_amount(id)
      params.require(:investment).fetch(id).permit(:amount, :round_id)
    end

end
